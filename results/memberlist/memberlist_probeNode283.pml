#define probeNode_m_config_IndirectChecks  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example469866808/state.go
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
	Chandef nackCh;
	int i;
	Chandef fallbackCh;
	Chandef ackCh;
	chan child_setProbeChannels0 = [0] of {int};
	int m_config_IndirectChecks = probeNode_m_config_IndirectChecks;
	bool state = false;
	
	if
	:: m_config_IndirectChecks + 1 > 0 -> 
		ackCh.size = m_config_IndirectChecks + 1;
		run AsyncChan(ackCh)
	:: else -> 
		run sync_monitor(ackCh)
	fi;
	
	if
	:: m_config_IndirectChecks + 1 > 0 -> 
		nackCh.size = m_config_IndirectChecks + 1;
		run AsyncChan(nackCh)
	:: else -> 
		run sync_monitor(nackCh)
	fi;
	run setProbeChannels(ackCh,nackCh,child_setProbeChannels0);
	child_setProbeChannels0?0;
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto HANDLE_REMOTE_FAILURE
			:: true -> 
				goto stop_process
			:: true -> 
				goto stop_process
			fi
		:: true;
		fi
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		fi;
		
		if
		:: true -> 
			goto stop_process
		fi;
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto HANDLE_REMOTE_FAILURE
			:: true -> 
				goto stop_process
			:: true -> 
				goto stop_process
			fi
		:: true;
		fi
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		fi;
		
		if
		:: true -> 
			goto stop_process
		fi;
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto HANDLE_REMOTE_FAILURE
			:: true -> 
				goto stop_process
			:: true -> 
				goto stop_process
			fi
		:: true;
		fi
	fi;
	do
	:: ackCh.async_rcv?0 -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: ackCh.async_send!0;
			:: ackCh.sync!0 -> 
				ackCh.sending?0
			fi
		:: true;
		fi;
		break
	:: ackCh.sync?0 -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: ackCh.async_send!0;
			:: ackCh.sync!0 -> 
				ackCh.sending?0
			fi
		:: true;
		fi;
		break
	:: true -> 
		break
	od;
HANDLE_REMOTE_FAILURE:	;
	
	if
	:: 1 > 0 -> 
		fallbackCh.size = 1;
		run AsyncChan(fallbackCh)
	:: else -> 
		run sync_monitor(fallbackCh)
	fi;
	
	if
	:: true -> 
		run Anonymous1(ackCh,nackCh,fallbackCh)
	:: true -> 
		fallbackCh.closing!true
	:: true -> 
		fallbackCh.closing!true
	fi;
	do
	:: ackCh.async_rcv?0 -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		break
	:: ackCh.sync?0 -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		break
	od;
	do
	:: fallbackCh.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: fallbackCh.async_rcv?0;
			:: fallbackCh.sync?0;
			fi;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		fi
	od
stop_process:}

proctype setProbeChannels(Chandef ackCh;Chandef nackCh;chan child) {
	bool closed; 
	int i;
	bool state;
stop_process:	child!0
}
proctype Anonymous1(Chandef ackCh;Chandef nackCh;Chandef fallbackCh) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: fallbackCh.async_send!0;
		:: fallbackCh.sync!0 -> 
			fallbackCh.sending?0
		fi
	:: true -> 
		
		if
		:: fallbackCh.async_send!0;
		:: fallbackCh.sync!0 -> 
			fallbackCh.sending?0
		fi
	fi;
stop_process:	fallbackCh.closing!true
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

