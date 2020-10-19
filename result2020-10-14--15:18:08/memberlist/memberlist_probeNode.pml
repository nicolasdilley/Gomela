#define probeNode_m_config_IndirectChecks  60
#define probeNode_kNodes  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example726862265/state.go
typedef Chandef {
	chan sync = [0] of {int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
}



init { 
	Chandef ackCh;
	int m_config_IndirectChecks = probeNode_m_config_IndirectChecks;
	chan child_msetProbeChannels0 = [0] of {int};
	int i;
	Chandef nackCh;
	Chandef fallbackCh;
	int kNodes = probeNode_kNodes;
	bool state = false;
	
	if
	:: m_config_IndirectChecks + 1 > 0 -> 
		ackCh.size = m_config_IndirectChecks + 1;
		run emptyChan(ackCh)
	:: else -> 
		run sync_monitor(ackCh)
	fi;
	
	if
	:: m_config_IndirectChecks + 1 > 0 -> 
		nackCh.size = m_config_IndirectChecks + 1;
		run emptyChan(nackCh)
	:: else -> 
		run sync_monitor(nackCh)
	fi;
	run msetProbeChannels(ackCh,nackCh,child_msetProbeChannels0);
	child_msetProbeChannels0?0;
	
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
	:: true;
	od;
HANDLE_REMOTE_FAILURE:	;
		for(i : 1.. kNodes) {
for10:
	};
	
	if
	:: 1 > 0 -> 
		fallbackCh.size = 1;
		run emptyChan(fallbackCh)
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

proctype msetProbeChannels(Chandef ackCh;Chandef nackCh;chan child) {
	bool closed; 
	int i;
	bool state;
	child!0;
stop_process:
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
	fallbackCh.closing!true;
stop_process:
}
proctype sync_monitor(Chandef ch) {
end: if
    :: ch.sending!false;
      run sync_monitor(ch)
    :: ch.closing?true ->
      run closedChan(ch)
    :: ch.is_closed!false ->
      run sync_monitor(ch)
    fi
stop_process:
}

proctype emptyChan(Chandef ch) {
end: if
	 :: ch.async_send?0 -> // a message has been received
    ch.num_msgs = ch.num_msgs + 1
    if
    :: ch.num_msgs == ch.size ->
      run fullChan(ch)
    :: else ->
      run neitherChan(ch)
    fi;
  :: ch.closing?true -> // closing the channel
    run closedChan(ch)
  :: ch.is_closed!false ->
    run emptyChan(ch) // sending channel is open 
  :: ch.sending!false ->
    run emptyChan(ch) // sending channel is open 
fi;
}

proctype fullChan(Chandef ch) {
end: if
  :: ch.async_rcv!0 ->
    ch.num_msgs = ch.num_msgs - 1
    if
    :: ch.num_msgs == 0 ->
      run emptyChan(ch)
    :: else ->
      run neitherChan(ch)
    fi;
  :: ch.closing?true -> // closing the channel
      run closedChan(ch)
  :: ch.is_closed!false -> // sending channel is open 
      run fullChan(ch)
  :: ch.sending!false ->
      run fullChan(ch)
fi;
}

proctype neitherChan(Chandef ch) {
end: if
  :: ch.async_send?0->
     ch.num_msgs = ch.num_msgs + 1
     if
     :: ch.num_msgs == ch.size ->
        run fullChan(ch)
     :: else ->
        run neitherChan(ch)
    fi;
  :: ch.async_rcv!0
     ch.num_msgs = ch.num_msgs - 1
     if
     :: ch.num_msgs == 0 ->
      run emptyChan(ch)
     :: else ->
      run neitherChan(ch)
     fi;
  :: ch.closing?true -> // closing the channel
      run closedChan(ch)
  :: ch.is_closed!false ->  // sending channel is open
     run neitherChan(ch)
  :: ch.sending!false ->  // sending channel is open
     run neitherChan(ch)
fi;
}

proctype closedChan(Chandef ch) {
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true -> // sending state of channel (closed)
    run closedChan(ch)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0 -> // can always receive on a closed chan
    run closedChan(ch)
  fi;
}

