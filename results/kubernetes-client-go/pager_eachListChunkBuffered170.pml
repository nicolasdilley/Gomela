#define eachListChunkBuffered_p_PageBufferSize  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example620095928/tools/pager/pager.go
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
	Chandef bgResultC;
	Chandef chunkC;
	int num_msgs = 0;
	bool state = false;
	int i;
	int p_PageBufferSize = eachListChunkBuffered_p_PageBufferSize;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: p_PageBufferSize > 0 -> 
		chunkC.size = p_PageBufferSize;
		run AsyncChan(chunkC)
	:: else -> 
		run sync_monitor(chunkC)
	fi;
	

	if
	:: 1 > 0 -> 
		bgResultC.size = 1;
		run AsyncChan(bgResultC)
	:: else -> 
		run sync_monitor(bgResultC)
	fi;
	run go_Anonymous0(chunkC,bgResultC);
	do
	:: true -> 
		

		if
		:: chunkC.async_rcv?state,num_msgs;
		:: chunkC.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for10: skip;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for10_end: skip
		fi
	od;
	for10_exit: skip;
	

	if
	:: bgResultC.async_rcv?state,num_msgs;
	:: bgResultC.sync?state,num_msgs;
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef chunkC;Chandef bgResultC) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	

	if
	:: bgResultC.async_send!0;
	:: bgResultC.sync!false,0 -> 
		bgResultC.sending?state
	fi;
	chunkC.closing!true
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

