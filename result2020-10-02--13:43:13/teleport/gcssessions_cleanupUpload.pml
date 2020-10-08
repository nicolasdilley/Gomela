#define lb_for165_0  -1
#define ub_for165_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example501245996/lib/events/gcssessions/gcsstream.go
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
	Chandef errorsCh;
	bool state = false;
	int objects = 5;
	Chandef semCh;
	int prefixes = 5;
	int i;
		for(i : 1.. prefixes) {
for10:		do
		:: true -> 
for11:			
			if
			:: true -> 
				break
			:: true;
			fi;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		od;
for11_exit:
	};
	
	if
	:: 32 > 0 -> 
		semCh.size = 32;
		run emptyChan(semCh)
	:: else -> 
		run sync_monitor(semCh)
	fi;
	
	if
	:: 32 > 0 -> 
		errorsCh.size = 32;
		run emptyChan(errorsCh)
	:: else -> 
		run sync_monitor(errorsCh)
	fi;
		for(i : 1.. objects) {
for20:		do
		:: semCh.async_send!0 -> 
			run Anonymous0(semCh,errorsCh);
			break
		:: semCh.sync!0 -> 
			semCh.sending?0;
			run Anonymous0(semCh,errorsCh);
			break
		:: true -> 
			goto stop_process
		od
	};
		for(i : 1.. objects) {
for30:		do
		:: true -> 
			goto stop_process
		od
	};
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef semCh;Chandef errorsCh) {
	bool closed; 
	int i;
	do
	:: errorsCh.async_send!0 -> 
		break
	:: errorsCh.sync!0 -> 
		errorsCh.sending?0;
		break
	:: true;
	od;
	
	if
	:: semCh.async_rcv?0;
	:: semCh.sync?0;
	fi;
stop_process:
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

