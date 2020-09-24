
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example244624373/miner/worker.go
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
	Chandef worker_taskCh;
	Chandef worker_txsCh;
	Chandef worker_resubmitIntervalCh;
	Chandef worker_chainSideCh;
	Chandef worker_exitCh;
	int i;
	Chandef worker_chainHeadCh;
	Chandef worker_newWorkCh;
	Chandef worker_resultCh;
	Chandef worker_startCh;
	Chandef worker_resubmitAdjustCh;
	bool state = false;
	
	if
	:: 4096 > 0 -> 
		worker_txsCh.size = 4096;
		run emptyChan(worker_txsCh)
	:: else -> 
		run sync_monitor(worker_txsCh)
	fi;
	
	if
	:: 10 > 0 -> 
		worker_chainHeadCh.size = 10;
		run emptyChan(worker_chainHeadCh)
	:: else -> 
		run sync_monitor(worker_chainHeadCh)
	fi;
	
	if
	:: 10 > 0 -> 
		worker_chainSideCh.size = 10;
		run emptyChan(worker_chainSideCh)
	:: else -> 
		run sync_monitor(worker_chainSideCh)
	fi;
	run sync_monitor(worker_newWorkCh);
	run sync_monitor(worker_taskCh);
	
	if
	:: 10 > 0 -> 
		worker_resultCh.size = 10;
		run emptyChan(worker_resultCh)
	:: else -> 
		run sync_monitor(worker_resultCh)
	fi;
	run sync_monitor(worker_exitCh);
	
	if
	:: 1 > 0 -> 
		worker_startCh.size = 1;
		run emptyChan(worker_startCh)
	:: else -> 
		run sync_monitor(worker_startCh)
	fi;
	run sync_monitor(worker_resubmitIntervalCh);
	
	if
	:: 10 > 0 -> 
		worker_resubmitAdjustCh.size = 10;
		run emptyChan(worker_resubmitAdjustCh)
	:: else -> 
		run sync_monitor(worker_resubmitAdjustCh)
	fi;
	
	if
	:: true -> 
		
		if
		:: worker_startCh.async_send!0;
		:: worker_startCh.sync!0 -> 
			worker_startCh.sending?0
		fi
	:: true;
	fi;
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

