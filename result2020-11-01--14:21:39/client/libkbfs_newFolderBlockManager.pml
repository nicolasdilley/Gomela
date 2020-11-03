
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example441703692/go/kbfs/libkbfs/folder_block_manager.go
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
	Chandef fbm_blocksToDeleteChan;
	Chandef fbm_archiveChan;
	Chandef fbm_forceReclamationChan;
	Chandef fbm_shutdownChan;
	Chandef fbm_archivePauseChan;
	Chandef fbm_blocksToDeletePauseChan;
	int i;
	
	if
	:: true -> 
		Chandef latestMergedChan;
		
		if
		:: 1 > 0 -> 
			latestMergedChan.size = 1;
			run emptyChan(latestMergedChan)
		:: else -> 
			run sync_monitor(latestMergedChan)
		fi
	:: true;
	fi;
	run sync_monitor(fbm_shutdownChan);
	
	if
	:: 500 > 0 -> 
		fbm_archiveChan.size = 500;
		run emptyChan(fbm_archiveChan)
	:: else -> 
		run sync_monitor(fbm_archiveChan)
	fi;
	run sync_monitor(fbm_archivePauseChan);
	
	if
	:: 25 > 0 -> 
		fbm_blocksToDeleteChan.size = 25;
		run emptyChan(fbm_blocksToDeleteChan)
	:: else -> 
		run sync_monitor(fbm_blocksToDeleteChan)
	fi;
	run sync_monitor(fbm_blocksToDeletePauseChan);
	
	if
	:: 1 > 0 -> 
		fbm_forceReclamationChan.size = 1;
		run emptyChan(fbm_forceReclamationChan)
	:: else -> 
		run sync_monitor(fbm_forceReclamationChan)
	fi;
	
	if
	:: true -> 
		goto stop_process
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

