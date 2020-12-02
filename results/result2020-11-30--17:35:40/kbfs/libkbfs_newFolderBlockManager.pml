
// /tmp/clone-example639689849/libkbfs/folder_block_manager.go
typedef Chandef {
	chan sync = [0] of {int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
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
			run AsyncChan(latestMergedChan)
		:: else -> 
			run sync_monitor(latestMergedChan)
		fi
	:: true;
	fi;
	run sync_monitor(fbm_shutdownChan);
	
	if
	:: 500 > 0 -> 
		fbm_archiveChan.size = 500;
		run AsyncChan(fbm_archiveChan)
	:: else -> 
		run sync_monitor(fbm_archiveChan)
	fi;
	run sync_monitor(fbm_archivePauseChan);
	
	if
	:: 25 > 0 -> 
		fbm_blocksToDeleteChan.size = 25;
		run AsyncChan(fbm_blocksToDeleteChan)
	:: else -> 
		run sync_monitor(fbm_blocksToDeleteChan)
	fi;
	run sync_monitor(fbm_blocksToDeletePauseChan);
	
	if
	:: 1 > 0 -> 
		fbm_forceReclamationChan.size = 1;
		run AsyncChan(fbm_forceReclamationChan)
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

proctype AsyncChan(Chandef ch) {
do
:: true ->
if
:: ch.closed -> 
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true; // sending state of channel (closed)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0; // can always receive on a closed chan
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!0 ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.is_closed!false; // sending channel is open 
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.is_closed!false;
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!0
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.is_closed!false;  // sending channel is open
		  :: ch.sending!false;  // sending channel is open
		fi;
	fi;
fi;
od;
}

proctype sync_monitor(Chandef ch) {
do
:: true
if
:: ch.closed ->
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true; // sending state of channel (closed)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
    :: ch.is_closed!false ->
    fi;
fi;
od
stop_process:
}

