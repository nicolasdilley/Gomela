
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example113174695/peer/peer.go
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
	Chandef p_quit;
	Chandef p_outQuit;
	Chandef p_queueQuit;
	Chandef p_inQuit;
	Chandef p_outputInvChan;
	Chandef p_sendDoneQueue;
	Chandef p_sendQueue;
	Chandef p_outputQueue;
	Chandef p_stallControl;
	int num_msgs = 0;
	bool state = false;
	int i;
	

	if
	:: 1 > 0 -> 
		p_stallControl.size = 1;
		run AsyncChan(p_stallControl)
	:: else -> 
		run sync_monitor(p_stallControl)
	fi;
	

	if
	:: 50 > 0 -> 
		p_outputQueue.size = 50;
		run AsyncChan(p_outputQueue)
	:: else -> 
		run sync_monitor(p_outputQueue)
	fi;
	

	if
	:: 1 > 0 -> 
		p_sendQueue.size = 1;
		run AsyncChan(p_sendQueue)
	:: else -> 
		run sync_monitor(p_sendQueue)
	fi;
	

	if
	:: 1 > 0 -> 
		p_sendDoneQueue.size = 1;
		run AsyncChan(p_sendDoneQueue)
	:: else -> 
		run sync_monitor(p_sendDoneQueue)
	fi;
	

	if
	:: 50 > 0 -> 
		p_outputInvChan.size = 50;
		run AsyncChan(p_outputInvChan)
	:: else -> 
		run sync_monitor(p_outputInvChan)
	fi;
	run sync_monitor(p_inQuit);
	run sync_monitor(p_queueQuit);
	run sync_monitor(p_outQuit);
	run sync_monitor(p_quit);
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

