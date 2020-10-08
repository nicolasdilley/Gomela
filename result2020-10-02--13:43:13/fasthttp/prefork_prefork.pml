
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example320924340/prefork/prefork.go
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
	int childProcs = 5;
	Chandef sigCh;
	bool state = false;
	int goMaxProcs = 5;
	int i;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: goMaxProcs > 0 -> 
		sigCh.size = goMaxProcs;
		run emptyChan(sigCh)
	:: else -> 
		run sync_monitor(sigCh)
	fi;
		for(i : 0.. goMaxProcs-1) {
for20:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		run Anonymous0(sigCh)
	};
for20_exit:	do
	:: sigCh.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: sigCh.async_rcv?0;
			:: sigCh.sync?0;
			fi;
			
			if
			:: true -> 
				break
			:: true;
			fi;
			
			if
			:: true -> 
				break
			:: true;
			fi;
			run Anonymous1(sigCh)
		fi
	od;
	goto stop_process;
		for(i : 1.. childProcs) {
for10:
	}
stop_process:}

proctype Anonymous0(Chandef sigCh) {
	bool closed; 
	int i;
	
	if
	:: sigCh.async_send!0;
	:: sigCh.sync!0 -> 
		sigCh.sending?0
	fi;
stop_process:
}
proctype Anonymous1(Chandef sigCh) {
	bool closed; 
	int i;
	
	if
	:: sigCh.async_send!0;
	:: sigCh.sync!0 -> 
		sigCh.sending?0
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

