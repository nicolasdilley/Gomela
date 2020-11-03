#define FillInJournalStatusUnflushedPaths_tlfIDs 0
#define FillInJournalStatusUnflushedPaths_numWorkers 1
#define FillInJournalStatusUnflushedPaths_up 3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example105184738/libkbfs/journal_server_util.go
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
	int tlfIDs = FillInJournalStatusUnflushedPaths_tlfIDs;
	Chandef unflushedPaths;
	bool state = false;
	Chandef unflushedBytes;
	int up = FillInJournalStatusUnflushedPaths_up;
	Chandef statusesToFetch;
	Chandef storedBytes;
	Chandef endEstimates;
	int numWorkers = FillInJournalStatusUnflushedPaths_numWorkers;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: tlfIDs > 0 -> 
		statusesToFetch.size = tlfIDs;
		run emptyChan(statusesToFetch)
	:: else -> 
		run sync_monitor(statusesToFetch)
	fi;
	
	if
	:: tlfIDs > 0 -> 
		unflushedPaths.size = tlfIDs;
		run emptyChan(unflushedPaths)
	:: else -> 
		run sync_monitor(unflushedPaths)
	fi;
	
	if
	:: tlfIDs > 0 -> 
		storedBytes.size = tlfIDs;
		run emptyChan(storedBytes)
	:: else -> 
		run sync_monitor(storedBytes)
	fi;
	
	if
	:: tlfIDs > 0 -> 
		unflushedBytes.size = tlfIDs;
		run emptyChan(unflushedBytes)
	:: else -> 
		run sync_monitor(unflushedBytes)
	fi;
	
	if
	:: tlfIDs > 0 -> 
		endEstimates.size = tlfIDs;
		run emptyChan(endEstimates)
	:: else -> 
		run sync_monitor(endEstimates)
	fi;
	
	if
	:: 0 != -1 && numWorkers-1 != -1 -> 
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


