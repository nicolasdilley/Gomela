#define maxConcurrentOutboundPeerRequests  5
#define lb_for116_1  -1
#define ub_for116_2  -1
#define maxConcurrentOutboundPeerRequests  5
#define lb_for81_4  -1
#define ub_for81_5  -1
#define lb_for289_6  -1
#define ub_for289_7  -1
#define lb_for202_8  -1
#define ub_for202_9  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example877474965/modules/gateway/gateway.go
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
	Chandef permanentListenClosedChan;
	int modules_BootstrapPeers = 5;
	Chandef nodeManagerClosedChan;
	bool state = false;
	Chandef peerManagerClosedChan;
	Chandef nodePurgerClosedChan;
	int i;
	
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
	
	if
	:: true -> 
		do
		:: true -> 
for10:
		:: true -> 
			break
		od
	:: true;
	fi;
	run sync_monitor(permanentListenClosedChan);
	
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
	run go_gpermanentListen(permanentListenClosedChan);
	run sync_monitor(peerManagerClosedChan);
	run go_gpermanentPeerManager(peerManagerClosedChan);
	run sync_monitor(nodeManagerClosedChan);
	run go_gpermanentNodeManager(nodeManagerClosedChan);
	run sync_monitor(nodePurgerClosedChan);
	run go_gpermanentNodePurger(nodePurgerClosedChan);
	goto stop_process
stop_process:}

proctype go_gpermanentListen(Chandef closeChan) {
	bool closed; 
	int i;
		for(i : lb_for116_1.. ub_for116_2) {
for20:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		do
		:: true;
		:: true -> 
			goto stop_process
		od
	};
for20_exit:	closeChan.closing!true;
stop_process:
}
proctype go_gpermanentPeerManager(Chandef closedChan) {
	bool closed; 
	int i;
	Chandef connectionLimiterChan;
	
	if
	:: maxConcurrentOutboundPeerRequests > 0 -> 
		connectionLimiterChan.size = maxConcurrentOutboundPeerRequests;
		run emptyChan(connectionLimiterChan)
	:: else -> 
		run sync_monitor(connectionLimiterChan)
	fi;
	do
	:: true -> 
for30:		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
		do
		:: true -> 
for31:			
			if
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				break
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
				fi
			:: true;
			fi;
			
			if
			:: connectionLimiterChan.async_send!0;
			:: connectionLimiterChan.sync!0 -> 
				connectionLimiterChan.sending?0
			fi;
			run Anonymous2(connectionLimiterChan,closedChan);
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			break
		od
	od;
for30_exit:	closedChan.closing!true;
stop_process:
}
proctype Anonymous2(Chandef connectionLimiterChan;Chandef closedChan) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: connectionLimiterChan.async_rcv?0;
	:: connectionLimiterChan.sync?0;
	fi;
stop_process:
}
proctype go_gpermanentNodeManager(Chandef closeChan) {
	bool closed; 
	int i;
	do
	:: true -> 
for40:		do
		:: true;
		:: true -> 
			goto stop_process
		od;
		
		if
		:: true -> 
			do
			:: true;
			:: true -> 
				goto stop_process
			od
		:: true -> 
			do
			:: true;
			:: true -> 
				goto stop_process
			od
		fi
	od;
for40_exit:	closeChan.closing!true;
stop_process:
}
proctype go_gpermanentNodePurger(Chandef closeChan) {
	bool closed; 
	int i;
	do
	:: true -> 
for50:		do
		:: true;
		:: true -> 
			goto stop_process
		od
	od;
for50_exit:	closeChan.closing!true;
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

