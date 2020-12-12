#define eachListChunkBuffered_p_PageBufferSize  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example680667842/tools/pager/pager.go
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
	int p_PageBufferSize = eachListChunkBuffered_p_PageBufferSize;
	Chandef chunkC;
	bool state = false;
	Chandef bgResultC;
	int i;
	
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
	run Anonymous0(chunkC,bgResultC);
	do
	:: chunkC.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: chunkC.async_rcv?0;
			:: chunkC.sync?0;
			fi;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		fi
	od;
	
	if
	:: bgResultC.async_rcv?0;
	:: bgResultC.sync?0;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef chunkC;Chandef bgResultC) {
	bool closed; 
	int i;
	bool state;
stop_process:	chunkC.closing!true;
	
	if
	:: bgResultC.async_send!0;
	:: bgResultC.sync!0 -> 
		bgResultC.sending?0
	fi
}
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

