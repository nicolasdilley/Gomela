#define doChunkedGetNonLiveBlocks_numChunks  60
#define doChunkedGetNonLiveBlocks_numWorkers  60
#define doChunkedGetNonLiveBlocks_liveCounts  60
#define lb_for1400_3  -1
#define ub_for1400_4  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example695274255/go/kbfs/libkbfs/folder_block_manager.go
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
	Chandef chunkResults;
	int i;
	int numWorkers = doChunkedGetNonLiveBlocks_numWorkers;
	Chandef chunks;
	int numChunks = doChunkedGetNonLiveBlocks_numChunks;
	int liveCounts = doChunkedGetNonLiveBlocks_liveCounts;
	bool state = false;
	
	if
	:: numChunks > 0 -> 
		chunks.size = numChunks;
		run emptyChan(chunks)
	:: else -> 
		run sync_monitor(chunks)
	fi;
	
	if
	:: numChunks > 0 -> 
		chunkResults.size = numChunks;
		run emptyChan(chunkResults)
	:: else -> 
		run sync_monitor(chunkResults)
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
for10_exit:	
	if
	:: lb_for1400_3 != -1 && ub_for1400_4 != -1 -> 
				for(i : lb_for1400_3.. ub_for1400_4) {
for20:			
			if
			:: chunks.async_send!0;
			:: chunks.sync!0 -> 
				chunks.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for20:			
			if
			:: chunks.async_send!0;
			:: chunks.sync!0 -> 
				chunks.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for20_exit:	chunks.closing!true;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	chunkResults.closing!true;
	do
	:: chunkResults.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: chunkResults.async_rcv?0;
			:: chunkResults.sync?0;
			fi
		fi
	od;
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

