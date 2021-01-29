#define doChunkedGetNonLiveBlocks_numChunks  3
#define ub_for1400_1  -2

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example267239056/go/kbfs/libkbfs/folder_block_manager.go
typedef Chandef {
	chan sync = [0] of {bool,int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {bool,int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}



init { 
	Chandef chunkResults;
	Chandef chunks;
	int num_msgs = 0;
	bool state = false;
	int i;
	int numChunks = doChunkedGetNonLiveBlocks_numChunks;
	

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
	

	if
	:: 0 != -2 && ub_for1400_1 != -2 -> 
				for(i : 0.. ub_for1400_1) {
			for20522: skip;
			

			if
			:: chunks.async_send!0;
			:: chunks.sync!false,0 -> 
				chunks.sending?state
			fi;
			for20_end522: skip
		};
		for20_exit522: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			

			if
			:: chunks.async_send!0;
			:: chunks.sync!false,0 -> 
				chunks.sending?state
			fi;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	chunks.closing!true;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	chunkResults.closing!true;
	do
	:: true -> 
		

		if
		:: chunkResults.async_rcv?state,num_msgs;
		:: chunkResults.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for30: skip;
			for30_end: skip
		fi
	od;
	for30_exit: skip;
	goto stop_process
stop_process:skip
}


 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
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
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,ch.num_msgs -> // can always receive on a closed chan
		 ch.num_msgs = ch.num_msgs - 1
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!false,ch.num_msgs ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!false,ch.num_msgs
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
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
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
    fi;
fi;
od
stop_process:
}

