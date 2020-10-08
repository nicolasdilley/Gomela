
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example942100504/staging/src/k8s.io/cloud-provider/controllers/route/route_controller.go
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
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Chandef rateLimiter;
	bool state = false;
	int nodeRoutes = 5;
	Wgdef wg;
	int node_Spec_PodCIDRs = 5;
	int i;
		for(i : 1.. routes) {
for10:
	};
	run wgMonitor(wg);
	
	if
	:: 200 > 0 -> 
		rateLimiter.size = 200;
		run emptyChan(rateLimiter)
	:: else -> 
		run sync_monitor(rateLimiter)
	fi;
		for(i : 1.. nodes) {
for20:				for(i : 1.. node_Spec_PodCIDRs) {
for21:			wg.Add!1;
			run Anonymous0(rateLimiter)
		}
	};
		for(i : 1.. routes) {
for30:		
		if
		:: true -> 
			
			if
			:: true -> 
				wg.Add!1;
				run Anonymous1(rateLimiter)
			:: true;
			fi
		:: true;
		fi
	};
	wg.Wait?0;
		for(i : 1.. nodes) {
for40:		wg.Add!1;
		
		if
		:: true -> 
			run Anonymous2(rateLimiter)
		:: true;
		fi;
				for(i : 1.. nodeRoutes) {
for41:			
			if
			:: true -> 
				break
			:: true;
			fi
		};
		run Anonymous3(rateLimiter)
	};
	wg.Wait?0;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef rateLimiter) {
	bool closed; 
	int i;
stop_process:
}
proctype Anonymous1(Chandef rateLimiter) {
	bool closed; 
	int i;
	
	if
	:: rateLimiter.async_send!0;
	:: rateLimiter.sync!0 -> 
		rateLimiter.sending?0
	fi;
	
	if
	:: rateLimiter.async_rcv?0;
	:: rateLimiter.sync?0;
	fi;
stop_process:
}
proctype Anonymous2(Chandef rateLimiter) {
	bool closed; 
	int i;
stop_process:
}
proctype Anonymous3(Chandef rateLimiter) {
	bool closed; 
	int i;
stop_process:
}
proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
	do
	:: wg.Add?i -> 
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 -> 
end:		
		if
		:: wg.Add?i -> 
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
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

