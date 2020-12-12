#define doChunkedGetNonLiveBlocks_numChunks  ??
#define lb_for1400_1  -1
#define ub_for1400_2  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example678508291/go/kbfs/libkbfs/folder_block_manager.go
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
	int i;
	Chandef chunkResults;
	Chandef chunks;
	int numChunks = doChunkedGetNonLiveBlocks_numChunks;
	bool state = false;
	
	if
	:: numChunks > 0 -> 
		chunks.size = numChunks;
		run AsyncChan(chunks)
	:: else -> 
		run sync_monitor(chunks)
	fi;
	
	if
	:: numChunks > 0 -> 
		chunkResults.size = numChunks;
		run AsyncChan(chunkResults)
	:: else -> 
		run sync_monitor(chunkResults)
	fi;
for10_exit:	
	if
	:: lb_for1400_1 != -2 && ub_for1400_2 != -2 -> 
				for(i : lb_for1400_1.. ub_for1400_2) {
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

