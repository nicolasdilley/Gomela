
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example720598285/agent/agent.go
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
	Chandef startError;
	Chandef started;
	bool state = false;
	Chandef timeout;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(started);
	run sync_monitor(timeout);
	run sync_monitor(startError);
	run Anonymous0(started,timeout,startError);
	run Anonymous1(started,timeout,startError);
	do
	:: started.async_rcv?0 -> 
		break
	:: started.sync?0 -> 
		break
	:: timeout.async_rcv?0 -> 
		goto stop_process
	:: timeout.sync?0 -> 
		goto stop_process
	od;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef started;Chandef timeout;Chandef startError) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		
		if
		:: startError.async_send!0;
		:: startError.sync!0 -> 
			startError.sending?0
		fi
	:: true -> 
		
		if
		:: started.async_send!0;
		:: started.sync!0 -> 
			started.sending?0
		fi
	:: true -> 
		
		if
		:: started.async_send!0;
		:: started.sync!0 -> 
			started.sending?0
		fi
	fi;
stop_process:
}
proctype Anonymous1(Chandef started;Chandef timeout;Chandef startError) {
	bool closed; 
	int i;
	
	if
	:: timeout.async_send!0;
	:: timeout.sync!0 -> 
		timeout.sending?0
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

