
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example006988768/go/datas/http_chunk_store.go
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
	chan child_datasbuildWriteValueRequest0 = [0] of {int};
	Chandef chunkChan;
	int num_msgs = 0;
	bool state = false;
	int i;
	

	if
	:: 1024 > 0 -> 
		chunkChan.size = 1024;
		run AsyncChan(chunkChan)
	:: else -> 
		run sync_monitor(chunkChan)
	fi;
	run go_Anonymous0(chunkChan);
	run datasbuildWriteValueRequest(chunkChan,child_datasbuildWriteValueRequest0);
	child_datasbuildWriteValueRequest0?0
stop_process:skip
}

proctype go_Anonymous0(Chandef chunkChan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ExtractChunks0 = [0] of {int};
	run ExtractChunks(chunkChan,child_ExtractChunks0);
	child_ExtractChunks0?0;
	chunkChan.closing!true;
	stop_process: skip
}
proctype ExtractChunks(Chandef chunkChan;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_extractChunks0 = [0] of {int};
	run extractChunks(chunkChan,child_extractChunks0);
	child_extractChunks0?0;
	stop_process: skip;
	child!0
}
proctype extractChunks(Chandef chunkChan;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Chandef ch;
	

	if
	:: 1 > 0 -> 
		ch.size = 1;
		run AsyncChan(ch)
	:: else -> 
		run sync_monitor(ch)
	fi;
	run go_Anonymous3(ch,chunkChan);
	do
	:: true -> 
		

		if
		:: ch.async_rcv?state,num_msgs;
		:: ch.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for20: skip;
			

			if
			:: chunkChan.async_send!0;
			:: chunkChan.sync!false,0 -> 
				chunkChan.sending?state
			fi;
			for20_end: skip
		fi
	od;
	for20_exit: skip;
	stop_process: skip;
	child!0
}
proctype go_Anonymous3(Chandef ch;Chandef chunkChan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_extract1 = [0] of {int};
	chan child_extract0 = [0] of {int};
	run extract(ch,child_extract0);
	child_extract0?0;
	

	if
	:: true -> 
		run extract(ch,child_extract1);
		child_extract1?0
	:: true;
	fi;
	stop_process: skip;
	ch.closing!true
}
proctype extract(Chandef chunks;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int mt_order=3;
	

	if
	:: mt_order-1 != -3 -> 
				for(i : 0.. mt_order-1) {
			for10: skip;
			

			if
			:: chunks.async_send!0;
			:: chunks.sync!false,0 -> 
				chunks.sending?state
			fi;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for10417: skip;
			

			if
			:: chunks.async_send!0;
			:: chunks.sync!false,0 -> 
				chunks.sending?state
			fi;
			for10_end417: skip
		:: true -> 
			break
		od;
		for10_exit417: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype datasbuildWriteValueRequest(Chandef chunkChan;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	run go_Anonymous6(chunkChan);
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype go_Anonymous6(Chandef chunkChan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		

		if
		:: chunkChan.async_rcv?state,num_msgs;
		:: chunkChan.sync?state,num_msgs;
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
	stop_process: skip
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


