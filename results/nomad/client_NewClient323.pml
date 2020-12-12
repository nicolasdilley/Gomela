
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example052815095/client/client.go
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
	Chandef c_triggerNodeUpdate;
	bool state = false;
	chan child_New0 = [0] of {int};
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
		run AsyncChan(c_allocUpdates)
	:: else -> 
		run sync_monitor(c_allocUpdates)
	fi;
	run sync_monitor(c_shutdownCh);
	run sync_monitor(c_triggerDiscoveryCh);
	
	if
	:: 8 > 0 -> 
		c_triggerNodeUpdate.size = 8;
		run AsyncChan(c_triggerNodeUpdate)
	:: else -> 
		run sync_monitor(c_triggerNodeUpdate)
	fi;
	
	if
	:: 8 > 0 -> 
		c_triggerEmitNodeEvent.size = 8;
		run AsyncChan(c_triggerEmitNodeEvent)
	:: else -> 
		run sync_monitor(c_triggerEmitNodeEvent)
	fi;
	run sync_monitor(c_fpInitialized);
	run sync_monitor(c_serversContactedCh);
	run New(c_shutdownCh,child_New0);
	child_New0?0;
	
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
	:: true -> 
		break
	od;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype New(Chandef shutdownCh;chan child) {
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

