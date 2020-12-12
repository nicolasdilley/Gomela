#define NewState_msgQueueSize  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example480438224/test/maverick/consensus/state.go
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
	Chandef cs_internalMsgQueue;
	int i;
	Chandef cs_done;
	Chandef cs_peerMsgQueue;
	Chandef cs_statsMsgQueue;
	int msgQueueSize = NewState_msgQueueSize;
	bool state = false;
	
	if
	:: msgQueueSize > 0 -> 
		cs_peerMsgQueue.size = msgQueueSize;
		run AsyncChan(cs_peerMsgQueue)
	:: else -> 
		run sync_monitor(cs_peerMsgQueue)
	fi;
	
	if
	:: msgQueueSize > 0 -> 
		cs_internalMsgQueue.size = msgQueueSize;
		run AsyncChan(cs_internalMsgQueue)
	:: else -> 
		run sync_monitor(cs_internalMsgQueue)
	fi;
	
	if
	:: msgQueueSize > 0 -> 
		cs_statsMsgQueue.size = msgQueueSize;
		run AsyncChan(cs_statsMsgQueue)
	:: else -> 
		run sync_monitor(cs_statsMsgQueue)
	fi;
	run sync_monitor(cs_done);
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

