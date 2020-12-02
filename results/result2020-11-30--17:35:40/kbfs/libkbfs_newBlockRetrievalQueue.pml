#define newBlockRetrievalQueue_workerQueueSize  3
#define newBlockRetrievalQueue_numWorkers  0
#define newBlockRetrievalQueue_numPrefetchWorkers  1

// /tmp/clone-example639689849/libkbfs/block_retrieval_queue.go
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
	Chandef workerCh;
	int numWorkers = newBlockRetrievalQueue_numWorkers;
	Chandef q_doneCh;
	int i;
	Chandef prefetchWorkerCh;
	int workerQueueSize = newBlockRetrievalQueue_workerQueueSize;
	int numPrefetchWorkers = newBlockRetrievalQueue_numPrefetchWorkers;
	bool state = false;
	
	if
	:: workerQueueSize > 0 -> 
		workerCh.size = workerQueueSize;
		run AsyncChan(workerCh)
	:: else -> 
		run sync_monitor(workerCh)
	fi;
	
	if
	:: workerQueueSize > 0 -> 
		prefetchWorkerCh.size = workerQueueSize;
		run AsyncChan(prefetchWorkerCh)
	:: else -> 
		run sync_monitor(prefetchWorkerCh)
	fi;
	run sync_monitor(q_doneCh);
	
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
for10_exit:	
	if
	:: 0 != -2 && numPrefetchWorkers-1 != -3 -> 
				for(i : 0.. numPrefetchWorkers-1) {
for20:
		}
	:: else -> 
		do
		:: true -> 
for20:
		:: true -> 
			break
		od
	fi;
for20_exit:	goto stop_process
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

