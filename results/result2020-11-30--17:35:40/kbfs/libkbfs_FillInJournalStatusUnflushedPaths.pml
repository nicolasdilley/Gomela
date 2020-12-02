#define FillInJournalStatusUnflushedPaths_tlfIDs  0

// /tmp/clone-example639689849/libkbfs/journal_server_util.go
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
	int tlfIDs = FillInJournalStatusUnflushedPaths_tlfIDs;
	Chandef unflushedPaths;
	bool state = false;
	Chandef unflushedBytes;
	int up = -2;
	Chandef statusesToFetch;
	Chandef storedBytes;
	Chandef endEstimates;
	int numWorkers = -2;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: tlfIDs > 0 -> 
		statusesToFetch.size = tlfIDs;
		run AsyncChan(statusesToFetch)
	:: else -> 
		run sync_monitor(statusesToFetch)
	fi;
	
	if
	:: tlfIDs > 0 -> 
		unflushedPaths.size = tlfIDs;
		run AsyncChan(unflushedPaths)
	:: else -> 
		run sync_monitor(unflushedPaths)
	fi;
	
	if
	:: tlfIDs > 0 -> 
		storedBytes.size = tlfIDs;
		run AsyncChan(storedBytes)
	:: else -> 
		run sync_monitor(storedBytes)
	fi;
	
	if
	:: tlfIDs > 0 -> 
		unflushedBytes.size = tlfIDs;
		run AsyncChan(unflushedBytes)
	:: else -> 
		run sync_monitor(unflushedBytes)
	fi;
	
	if
	:: tlfIDs > 0 -> 
		endEstimates.size = tlfIDs;
		run AsyncChan(endEstimates)
	:: else -> 
		run sync_monitor(endEstimates)
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
for10_exit:		for(i : 0.. tlfIDs-1) {
for20:		
		if
		:: statusesToFetch.async_send!0;
		:: statusesToFetch.sync!0 -> 
			statusesToFetch.sending?0
		fi
	};
	statusesToFetch.closing!true;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	unflushedPaths.closing!true;
	storedBytes.closing!true;
	unflushedBytes.closing!true;
	endEstimates.closing!true;
	do
	:: unflushedPaths.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: unflushedPaths.async_rcv?0;
			:: unflushedPaths.sync?0;
			fi;
						for(i : 0.. up-1) {
for31:
			}
		fi
	od;
	
	if
	:: true -> 
		do
		:: storedBytes.is_closed?state -> 
			if
			:: state -> 
				break
			:: else -> 
				
				if
				:: storedBytes.async_rcv?0;
				:: storedBytes.sync?0;
				fi
			fi
		od;
		do
		:: unflushedBytes.is_closed?state -> 
			if
			:: state -> 
				break
			:: else -> 
				
				if
				:: unflushedBytes.async_rcv?0;
				:: unflushedBytes.sync?0;
				fi
			fi
		od;
		do
		:: endEstimates.is_closed?state -> 
			if
			:: state -> 
				break
			:: else -> 
				
				if
				:: endEstimates.async_rcv?0;
				:: endEstimates.sync?0;
				fi
			fi
		od
	:: true -> 
		do
		:: storedBytes.is_closed?state -> 
			if
			:: state -> 
				break
			:: else -> 
				
				if
				:: storedBytes.async_rcv?0;
				:: storedBytes.sync?0;
				fi
			fi
		od;
		do
		:: unflushedBytes.is_closed?state -> 
			if
			:: state -> 
				break
			:: else -> 
				
				if
				:: unflushedBytes.async_rcv?0;
				:: unflushedBytes.sync?0;
				fi
			fi
		od;
		do
		:: endEstimates.is_closed?state -> 
			if
			:: state -> 
				break
			:: else -> 
				
				if
				:: endEstimates.async_rcv?0;
				:: endEstimates.sync?0;
				fi
			fi
		od
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

