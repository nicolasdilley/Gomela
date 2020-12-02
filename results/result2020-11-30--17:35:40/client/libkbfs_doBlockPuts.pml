#define doBlockPuts_blockCount  1
#define doBlockPuts_numWorkers  1

// /tmp/clone-example545132187/go/kbfs/libkbfs/block_util.go
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
	Chandef blocksToRemoveChan;
	int i;
	int numWorkers = doBlockPuts_numWorkers;
	Chandef blocks;
	int blockCount = doBlockPuts_blockCount;
	int bps_Ptrs14822 = -2;
	bool state = false;
	
	if
	:: blockCount > 0 -> 
		blocks.size = blockCount;
		run AsyncChan(blocks)
	:: else -> 
		run sync_monitor(blocks)
	fi;
	
	if
	:: numWorkers > 0 -> 
		blocksToRemoveChan.size = numWorkers;
		run AsyncChan(blocksToRemoveChan)
	:: else -> 
		run sync_monitor(blocksToRemoveChan)
	fi;
	
	if
	:: 0 != -2 && numWorkers-1 != -3 -> 
				for(i : 0.. numWorkers-1) {
for10:
		}
	:: else -> 
		do
		:: true -> 
for10:
		:: true -> 
			break
		od
	fi;
for10_exit:		for(i : 0.. bps_Ptrs14822-1) {
for20:		
		if
		:: blocks.async_send!0;
		:: blocks.sync!0 -> 
			blocks.sending?0
		fi
	};
	blocks.closing!true;
	blocksToRemoveChan.closing!true;
	
	if
	:: true -> 
		do
		:: blocksToRemoveChan.is_closed?state -> 
			if
			:: state -> 
				break
			:: else -> 
				
				if
				:: blocksToRemoveChan.async_rcv?0;
				:: blocksToRemoveChan.sync?0;
				fi
			fi
		od
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

