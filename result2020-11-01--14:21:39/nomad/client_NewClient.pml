
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example960382288/client/client.go
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
	Chandef c_triggerNodeUpdate;
	bool state = false;
	chan child_serversNew0 = [0] of {int};
	Chandef c_shutdownCh;
	Chandef c_fpInitialized;
	chan child_clientnewHeartbeatStop2 = [0] of {int};
	Chandef c_allocUpdates;
	Chandef c_triggerDiscoveryCh;
	Chandef c_triggerEmitNodeEvent;
	Chandef c_serversContactedCh;
	chan child_clientNewFingerprintManager1 = [0] of {int};
	int i;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: 64 > 0 -> 
		c_allocUpdates.size = 64;
		run emptyChan(c_allocUpdates)
	:: else -> 
		run sync_monitor(c_allocUpdates)
	fi;
	run sync_monitor(c_shutdownCh);
	run sync_monitor(c_triggerDiscoveryCh);
	
	if
	:: 8 > 0 -> 
		c_triggerNodeUpdate.size = 8;
		run emptyChan(c_triggerNodeUpdate)
	:: else -> 
		run sync_monitor(c_triggerNodeUpdate)
	fi;
	
	if
	:: 8 > 0 -> 
		c_triggerEmitNodeEvent.size = 8;
		run emptyChan(c_triggerEmitNodeEvent)
	:: else -> 
		run sync_monitor(c_triggerEmitNodeEvent)
	fi;
	run sync_monitor(c_fpInitialized);
	run sync_monitor(c_serversContactedCh);
	run serversNew(c_shutdownCh,child_serversNew0);
	child_serversNew0?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run clientNewFingerprintManager(c_shutdownCh,child_clientNewFingerprintManager1);
	child_clientNewFingerprintManager1?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run clientnewHeartbeatStop(c_shutdownCh,child_clientnewHeartbeatStop2);
	child_clientnewHeartbeatStop2?0;
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: c_triggerDiscoveryCh.async_send!0;
			:: c_triggerDiscoveryCh.sync!0 -> 
				c_triggerDiscoveryCh.sending?0
			fi
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true;
	od;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype serversNew(Chandef shutdownCh;chan child) {
	bool closed; 
	int i;
	bool state;
	goto stop_process;
stop_process:	child!0
}
proctype clientNewFingerprintManager(Chandef shutdownCh;chan child) {
	bool closed; 
	int i;
	bool state;
	goto stop_process;
stop_process:	child!0
}
proctype clientnewHeartbeatStop(Chandef shutdownCh;chan child) {
	bool closed; 
	int i;
	bool state;
	Chandef h_allocHookCh;
	run sync_monitor(h_allocHookCh);
	goto stop_process;
stop_process:	child!0
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

