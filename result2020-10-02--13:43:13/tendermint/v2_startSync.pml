#define lb_for289_0  -1
#define ub_for289_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example330861849/blockchain/v2/reactor.go
typedef Chandef {
	chan sync = [0] of {int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
}



init { 
	Chandef r_events;
	bool state = false;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: 1000 > 0 -> 
		r_events.size = 1000;
		run emptyChan(r_events)
	:: else -> 
		run sync_monitor(r_events)
	fi;
	run go_rdemux(r_events);
	goto stop_process
stop_process:}

proctype go_rdemux(Chandef events) {
	bool closed; 
	int i;
	Chandef doProcessBlockCh;
	Chandef doScheduleCh;
	Chandef doPrunePeerCh;
	Chandef doStatusCh;
	
	if
	:: 1 > 0 -> 
		doProcessBlockCh.size = 1;
		run emptyChan(doProcessBlockCh)
	:: else -> 
		run sync_monitor(doProcessBlockCh)
	fi;
	
	if
	:: 1 > 0 -> 
		doPrunePeerCh.size = 1;
		run emptyChan(doPrunePeerCh)
	:: else -> 
		run sync_monitor(doPrunePeerCh)
	fi;
	
	if
	:: 1 > 0 -> 
		doScheduleCh.size = 1;
		run emptyChan(doScheduleCh)
	:: else -> 
		run sync_monitor(doScheduleCh)
	fi;
	
	if
	:: 1 > 0 -> 
		doStatusCh.size = 1;
		run emptyChan(doStatusCh)
	:: else -> 
		run sync_monitor(doStatusCh)
	fi;
	
	if
	:: doStatusCh.async_send!0;
	:: doStatusCh.sync!0 -> 
		doStatusCh.sending?0
	fi;
	do
	:: true -> 
for10:		do
		:: true -> 
			do
			:: doProcessBlockCh.async_send!0 -> 
				break
			:: doProcessBlockCh.sync!0 -> 
				doProcessBlockCh.sending?0;
				break
			:: true -> 
				break
			od
		:: true -> 
			do
			:: doPrunePeerCh.async_send!0 -> 
				break
			:: doPrunePeerCh.sync!0 -> 
				doPrunePeerCh.sending?0;
				break
			:: true -> 
				break
			od
		:: true -> 
			do
			:: doScheduleCh.async_send!0 -> 
				break
			:: doScheduleCh.sync!0 -> 
				doScheduleCh.sending?0;
				break
			:: true -> 
				break
			od
		:: true -> 
			do
			:: doStatusCh.async_send!0 -> 
				break
			:: doStatusCh.sync!0 -> 
				doStatusCh.sending?0;
				break
			:: true -> 
				break
			od
		:: doScheduleCh.async_rcv?0 -> 
			break
		:: doScheduleCh.sync?0 -> 
			break
		:: doPrunePeerCh.async_rcv?0 -> 
			break
		:: doPrunePeerCh.sync?0 -> 
			break
		:: doProcessBlockCh.async_rcv?0 -> 
			break
		:: doProcessBlockCh.sync?0 -> 
			break
		:: doStatusCh.async_rcv?0 -> 
			break
		:: doStatusCh.sync?0 -> 
			break
		od
	od;
for10_exit:stop_process:
}
proctype sync_monitor(Chandef ch) {
end: if
    :: ch.sending!false;
      run sync_monitor(ch)
    :: ch.closing?true ->
      run closedChan(ch)
    :: ch.is_closed!false ->
      run sync_monitor(ch)
    fi
stop_process:
}

proctype emptyChan(Chandef ch) {
end: if
	 :: ch.async_send?0 -> // a message has been received
    ch.num_msgs = ch.num_msgs + 1
    if
    :: ch.num_msgs == ch.size ->
      run fullChan(ch)
    :: else ->
      run neitherChan(ch)
    fi;
  :: ch.closing?true -> // closing the channel
    run closedChan(ch)
  :: ch.is_closed!false ->
    run emptyChan(ch) // sending channel is open 
  :: ch.sending!false ->
    run emptyChan(ch) // sending channel is open 
fi;
}

proctype fullChan(Chandef ch) {
end: if
  :: ch.async_rcv!0 ->
    ch.num_msgs = ch.num_msgs - 1
    if
    :: ch.num_msgs == 0 ->
      run emptyChan(ch)
    :: else ->
      run neitherChan(ch)
    fi;
  :: ch.closing?true -> // closing the channel
      run closedChan(ch)
  :: ch.is_closed!false -> // sending channel is open 
      run fullChan(ch)
  :: ch.sending!false ->
      run fullChan(ch)
fi;
}

proctype neitherChan(Chandef ch) {
end: if
  :: ch.async_send?0->
     ch.num_msgs = ch.num_msgs + 1
     if
     :: ch.num_msgs == ch.size ->
        run fullChan(ch)
     :: else ->
        run neitherChan(ch)
    fi;
  :: ch.async_rcv!0
     ch.num_msgs = ch.num_msgs - 1
     if
     :: ch.num_msgs == 0 ->
      run emptyChan(ch)
     :: else ->
      run neitherChan(ch)
     fi;
  :: ch.closing?true -> // closing the channel
      run closedChan(ch)
  :: ch.is_closed!false ->  // sending channel is open
     run neitherChan(ch)
  :: ch.sending!false ->  // sending channel is open
     run neitherChan(ch)
fi;
}

proctype closedChan(Chandef ch) {
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true -> // sending state of channel (closed)
    run closedChan(ch)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0 -> // can always receive on a closed chan
    run closedChan(ch)
  fi;
}

