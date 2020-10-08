
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example840004700/memberlist.go
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
	Chandef notifyCh;
	int i;
	chan child_maliveNode2 = [0] of {int};
	bool state = false;
	run sync_monitor(notifyCh);
	run maliveNode(notifyCh,child_maliveNode0);
	child_maliveNode2?0;
	
	if
	:: true -> 
		do
		:: notifyCh.async_rcv?0 -> 
			break
		:: notifyCh.sync?0 -> 
			break
		:: true -> 
			goto stop_process
		od
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype maliveNode(Chandef notify;chan child) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	
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
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		
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
			:: true -> 
				goto stop_process
			fi
		:: true;
		fi
	:: true -> 
		
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
			:: true -> 
				goto stop_process
			fi
		:: true;
		fi
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
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		chan child_mencodeBroadcastNotify1 = [0] of {int};
		run mencodeBroadcastNotify(notify,child_mencodeBroadcastNotify0);
		child_mencodeBroadcastNotify1?0
	:: true -> 
		chan child_mencodeBroadcastNotify1 = [0] of {int};
		run mencodeBroadcastNotify(notify,child_mencodeBroadcastNotify0);
		child_mencodeBroadcastNotify1?0
	fi;
	child!0;
stop_process:
}
proctype mencodeBroadcastNotify(Chandef notify;chan child) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		chan child_mqueueBroadcast0 = [0] of {int};
		run mqueueBroadcast(notify,child_mqueueBroadcast0);
		child_mqueueBroadcast0?0
	:: true -> 
		chan child_mqueueBroadcast0 = [0] of {int};
		run mqueueBroadcast(notify,child_mqueueBroadcast0);
		child_mqueueBroadcast0?0
	fi;
	child!0;
stop_process:
}
proctype mqueueBroadcast(Chandef notify;chan child) {
	bool closed; 
	int i;
	child!0;
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

