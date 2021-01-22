#define Start_t_AllowedPendingMessages  0
#define Start_t_MaxTCPConnections  0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example387426604/plugins/inputs/tcp_listener/tcp_listener.go
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
	Chandef t_accept;
	Chandef t_done;
	Chandef t_in;
	int num_msgs = 0;
	bool state = false;
	int i;
	int t_MaxTCPConnections = Start_t_MaxTCPConnections;
	int t_AllowedPendingMessages = Start_t_AllowedPendingMessages;
	

	if
	:: t_AllowedPendingMessages > 0 -> 
		t_in.size = t_AllowedPendingMessages;
		run AsyncChan(t_in)
	:: else -> 
		run sync_monitor(t_in)
	fi;
	run sync_monitor(t_done);
	

	if
	:: t_MaxTCPConnections > 0 -> 
		t_accept.size = t_MaxTCPConnections;
		run AsyncChan(t_accept)
	:: else -> 
		run sync_monitor(t_accept)
	fi;
	

	if
	:: 0 != -2 && t_MaxTCPConnections-1 != -3 -> 
				for(i : 0.. t_MaxTCPConnections-1) {
			for10652: skip;
			

			if
			:: t_accept.async_send!0;
			:: t_accept.sync!false,0 -> 
				t_accept.sending?state
			fi;
			for10_end652: skip
		};
		for10_exit652: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			

			if
			:: t_accept.async_send!0;
			:: t_accept.sync!false,0 -> 
				t_accept.sending?state
			fi;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

