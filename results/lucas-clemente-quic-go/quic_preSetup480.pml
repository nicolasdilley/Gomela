#define preSetup_protocol_MaxSessionUnprocessedPackets  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example337120852/session.go
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
	Chandef s_sendingScheduled;
	Chandef s_closeChan;
	Chandef s_receivedPackets;
	Chandef s_earlySessionReadyChan;
	int num_msgs = 0;
	bool state = false;
	int i;
	int protocol_MaxSessionUnprocessedPackets = preSetup_protocol_MaxSessionUnprocessedPackets;
	run sync_monitor(s_earlySessionReadyChan);
	

	if
	:: protocol_MaxSessionUnprocessedPackets > 0 -> 
		s_receivedPackets.size = protocol_MaxSessionUnprocessedPackets;
		run AsyncChan(s_receivedPackets)
	:: else -> 
		run sync_monitor(s_receivedPackets)
	fi;
	

	if
	:: 1 > 0 -> 
		s_closeChan.size = 1;
		run AsyncChan(s_closeChan)
	:: else -> 
		run sync_monitor(s_closeChan)
	fi;
	

	if
	:: 1 > 0 -> 
		s_sendingScheduled.size = 1;
		run AsyncChan(s_sendingScheduled)
	:: else -> 
		run sync_monitor(s_sendingScheduled)
	fi
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

