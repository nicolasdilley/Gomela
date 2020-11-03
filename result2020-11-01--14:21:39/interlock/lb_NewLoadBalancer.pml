#define NewLoadBalancer_nc 0
#define NewLoadBalancer_cnt_NetworkSettings_Networks 1
#define NewLoadBalancer_retries 1
#define NewLoadBalancer_proxyContainers 0
#define NewLoadBalancer_proxyNetworks 3
#define lb_for150_5  -1
#define ub_for150_6  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example349670532/ext/lb/lb.go
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
	int proxyContainers = NewLoadBalancer_proxyContainers;
	Chandef proxyNetworkCleanupChan;
	Chandef errChan;
	int cnt_NetworkSettings_Networks = NewLoadBalancer_cnt_NetworkSettings_Networks;
	int i;
	Chandef lbUpdateChan;
	int nc = NewLoadBalancer_nc;
	int retries = NewLoadBalancer_retries;
	int proxyNetworks = NewLoadBalancer_proxyNetworks;
	bool state = false;
	run sync_monitor(errChan);
	run Anonymous0(errChan,lbUpdateChan,proxyNetworkCleanupChan);
	run sync_monitor(lbUpdateChan);
	run sync_monitor(proxyNetworkCleanupChan);
	
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
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		goto stop_process
	fi;
	run Anonymous1(errChan,lbUpdateChan,proxyNetworkCleanupChan);
	run Anonymous2(errChan,lbUpdateChan,proxyNetworkCleanupChan);
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef errChan;Chandef lbUpdateChan;Chandef proxyNetworkCleanupChan) {
	bool closed; 
	int i;
	bool state;
	do
	:: errChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: errChan.async_rcv?0;
			:: errChan.sync?0;
			fi
		fi
	od;
stop_process:
}
proctype Anonymous1(Chandef errChan;Chandef lbUpdateChan;Chandef proxyNetworkCleanupChan) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for20:		
		if
		:: proxyNetworkCleanupChan.async_rcv?0;
		:: proxyNetworkCleanupChan.sync?0;
		fi;
				for(i : 0.. nc-1) {
for21:						for(i : 0.. cnt_NetworkSettings_Networks-1) {
for22:				
				if
				:: true -> 
					
					if
					:: 0 != -1 && retries-1 != -1 -> 
												for(i : 0.. retries-1) {
for23:							
							if
							:: true -> 
								break
							:: true;
							fi
						}
					:: else -> 
						do
						:: true -> 
for23:							
							if
							:: true -> 
								break
							:: true;
							fi
						:: true -> 
							break
						od
					fi;
for23_exit:
				:: true;
				fi
			}
		}
	od;
for20_exit:stop_process:
}
proctype Anonymous2(Chandef errChan;Chandef lbUpdateChan;Chandef proxyNetworkCleanupChan) {
	bool closed; 
	int i;
	bool state;
	do
	:: lbUpdateChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: lbUpdateChan.async_rcv?0;
			:: lbUpdateChan.sync?0;
			fi;
			
			if
			:: true -> 
				
				if
				:: errChan.async_send!0;
				:: errChan.sync!0 -> 
					errChan.sending?0
				fi
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: errChan.async_send!0;
				:: errChan.sync!0 -> 
					errChan.sending?0
				fi
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: errChan.async_send!0;
				:: errChan.sync!0 -> 
					errChan.sending?0
				fi
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: errChan.async_send!0;
				:: errChan.sync!0 -> 
					errChan.sending?0
				fi
			:: true;
			fi;
			

			if
			:: true;
			:: true;
			:: true -> 
				
				if
				:: errChan.async_send!0;
				:: errChan.sync!0 -> 
					errChan.sending?0
				fi
			fi;
						for(i : 0.. proxyContainers-1) {
for31:								for(i : 0.. proxyNetworks-1) {
for32:
				}
			};
			
			if
			:: true -> 
				
				if
				:: errChan.async_send!0;
				:: errChan.sync!0 -> 
					errChan.sending?0
				fi
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: errChan.async_send!0;
				:: errChan.sync!0 -> 
					errChan.sending?0
				fi
			:: true;
			fi
		fi
	od;
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


