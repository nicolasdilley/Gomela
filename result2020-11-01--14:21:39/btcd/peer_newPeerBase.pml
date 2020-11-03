
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example873333002/peer/peer.go
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
	Chandef p_inQuit;
	Chandef p_outputQueue;
	int i;
	Chandef p_sendDoneQueue;
	Chandef p_outQuit;
	Chandef p_stallControl;
	Chandef p_sendQueue;
	Chandef p_outputInvChan;
	Chandef p_queueQuit;
	Chandef p_quit;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		p_stallControl.size = 1;
		run emptyChan(p_stallControl)
	:: else -> 
		run sync_monitor(p_stallControl)
	fi;
	
	if
	:: 50 > 0 -> 
		p_outputQueue.size = 50;
		run emptyChan(p_outputQueue)
	:: else -> 
		run sync_monitor(p_outputQueue)
	fi;
	
	if
	:: 1 > 0 -> 
		p_sendQueue.size = 1;
		run emptyChan(p_sendQueue)
	:: else -> 
		run sync_monitor(p_sendQueue)
	fi;
	
	if
	:: 1 > 0 -> 
		p_sendDoneQueue.size = 1;
		run emptyChan(p_sendDoneQueue)
	:: else -> 
		run sync_monitor(p_sendDoneQueue)
	fi;
	
	if
	:: 50 > 0 -> 
		p_outputInvChan.size = 50;
		run emptyChan(p_outputInvChan)
	:: else -> 
		run sync_monitor(p_outputInvChan)
	fi;
	run sync_monitor(p_inQuit);
	run sync_monitor(p_queueQuit);
	run sync_monitor(p_outQuit);
	run sync_monitor(p_quit);
	goto stop_process
stop_process:}

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

