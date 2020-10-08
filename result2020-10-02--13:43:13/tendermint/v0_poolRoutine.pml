#define lb_for274_0  -1
#define ub_for274_1  -1
#define lb_for310_2  -1
#define ub_for310_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example330861849/blockchain/v0/reactor.go
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
	int i;
	Chandef didProcessCh;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		didProcessCh.size = 1;
		run emptyChan(didProcessCh)
	:: else -> 
		run sync_monitor(didProcessCh)
	fi;
	run Anonymous0(didProcessCh);
FOR_LOOP:		do
	:: true -> 
for20:		do
		:: true -> 
			
			if
			:: true -> 
				goto FOR_LOOP
			:: true;
			fi
		:: true -> 
			do
			:: didProcessCh.async_send!0 -> 
				break
			:: didProcessCh.sync!0 -> 
				didProcessCh.sending?0;
				break
			:: true -> 
				break
			od
		:: didProcessCh.async_rcv?0 -> 
			
			if
			:: true -> 
				
				if
				:: didProcessCh.async_send!0;
				:: didProcessCh.sync!0 -> 
					didProcessCh.sending?0
				fi
			:: true -> 
				
				if
				:: didProcessCh.async_send!0;
				:: didProcessCh.sync!0 -> 
					didProcessCh.sending?0
				fi
			fi;
			break
		:: didProcessCh.sync?0 -> 
			
			if
			:: true -> 
				
				if
				:: didProcessCh.async_send!0;
				:: didProcessCh.sync!0 -> 
					didProcessCh.sending?0
				fi
			:: true -> 
				
				if
				:: didProcessCh.async_send!0;
				:: didProcessCh.sync!0 -> 
					didProcessCh.sending?0
				fi
			fi;
			break
		:: true -> 
			goto FOR_LOOP
		od
	od;
for20_exit:
stop_process:}

proctype Anonymous0(Chandef didProcessCh) {
	bool closed; 
	int i;
		for(i : lb_for274_0.. ub_for274_1) {
for10:		do
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		:: true;
		od
	};
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

