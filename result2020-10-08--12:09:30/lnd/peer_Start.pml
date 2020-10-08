
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example975776158/peer/brontide.go
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
	bool state = false;
	Chandef msgChan;
	Chandef readErr;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: 1 > 0 -> 
		readErr.size = 1;
		run emptyChan(readErr)
	:: else -> 
		run sync_monitor(readErr)
	fi;
	
	if
	:: 1 > 0 -> 
		msgChan.size = 1;
		run emptyChan(msgChan)
	:: else -> 
		run sync_monitor(msgChan)
	fi;
	run Anonymous0(readErr,msgChan);
	do
	:: true -> 
		goto stop_process
	:: readErr.async_rcv?0 -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		break
	:: readErr.sync?0 -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		break
	od;
	
	if
	:: msgChan.async_rcv?0;
	:: msgChan.sync?0;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef readErr;Chandef msgChan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: readErr.async_send!0;
		:: readErr.sync!0 -> 
			readErr.sending?0
		fi;
		
		if
		:: msgChan.async_send!0;
		:: msgChan.sync!0 -> 
			msgChan.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: readErr.async_send!0;
	:: readErr.sync!0 -> 
		readErr.sending?0
	fi;
	
	if
	:: msgChan.async_send!0;
	:: msgChan.sync!0 -> 
		msgChan.sending?0
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

