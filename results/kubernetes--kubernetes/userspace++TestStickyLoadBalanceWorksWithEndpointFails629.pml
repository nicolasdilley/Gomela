
// https://github.com/kubernetes/kubernetes/blob/master/pkg/proxy/userspace/roundrobin_test.go#L629
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestStickyLoadBalanceWorksWithEndpointFails6290 = [1] of {int};
	run TestStickyLoadBalanceWorksWithEndpointFails629(child_TestStickyLoadBalanceWorksWithEndpointFails6290)
stop_process:skip
}

proctype TestStickyLoadBalanceWorksWithEndpointFails629(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_expectEndpointWithSessionAffinityReset5114 = [1] of {int};
	chan child_expectEndpointWithSessionAffinityReset5113 = [1] of {int};
	chan child_expectEndpointWithSessionAffinityReset5112 = [1] of {int};
	chan child_expectEndpointWithSessionAffinityReset5111 = [1] of {int};
	chan child_expectEndpointWithSessionAffinityReset5110 = [1] of {int};
	chan child_expectEndpoint419 = [1] of {int};
	chan child_expectEndpointWithSessionAffinityReset518 = [1] of {int};
	chan child_expectEndpointWithSessionAffinityReset517 = [1] of {int};
	chan child_expectEndpointWithSessionAffinityReset516 = [1] of {int};
	chan child_NextEndpoint1365 = [1] of {int};
	chan child_NextEndpoint1364 = [1] of {int};
	chan child_NextEndpoint1363 = [1] of {int};
	chan child_OnEndpointsAdd2232 = [1] of {int};
	chan child_NewService851 = [1] of {int};
	chan child_NextEndpoint1360 = [1] of {int};
	Mutexdef loadBalancer_lock;
	run mutexMonitor(loadBalancer_lock);
	run NextEndpoint136(loadBalancer_lock,child_NextEndpoint1360);
	child_NextEndpoint1360?0;
	run NewService85(loadBalancer_lock,child_NewService851);
	child_NewService851?0;
	run OnEndpointsAdd223(loadBalancer_lock,child_OnEndpointsAdd2232);
	child_OnEndpointsAdd2232?0;
	run NextEndpoint136(loadBalancer_lock,child_NextEndpoint1363);
	child_NextEndpoint1363?0;
	run NextEndpoint136(loadBalancer_lock,child_NextEndpoint1364);
	child_NextEndpoint1364?0;
	run NextEndpoint136(loadBalancer_lock,child_NextEndpoint1365);
	child_NextEndpoint1365?0;
	run expectEndpointWithSessionAffinityReset51(loadBalancer_lock,child_expectEndpointWithSessionAffinityReset516);
	child_expectEndpointWithSessionAffinityReset516?0;
	run expectEndpointWithSessionAffinityReset51(loadBalancer_lock,child_expectEndpointWithSessionAffinityReset517);
	child_expectEndpointWithSessionAffinityReset517?0;
	run expectEndpointWithSessionAffinityReset51(loadBalancer_lock,child_expectEndpointWithSessionAffinityReset518);
	child_expectEndpointWithSessionAffinityReset518?0;
	run expectEndpoint41(loadBalancer_lock,child_expectEndpoint419);
	child_expectEndpoint419?0;
	run expectEndpointWithSessionAffinityReset51(loadBalancer_lock,child_expectEndpointWithSessionAffinityReset5110);
	child_expectEndpointWithSessionAffinityReset5110?0;
	run expectEndpointWithSessionAffinityReset51(loadBalancer_lock,child_expectEndpointWithSessionAffinityReset5111);
	child_expectEndpointWithSessionAffinityReset5111?0;
	run expectEndpointWithSessionAffinityReset51(loadBalancer_lock,child_expectEndpointWithSessionAffinityReset5112);
	child_expectEndpointWithSessionAffinityReset5112?0;
	run expectEndpointWithSessionAffinityReset51(loadBalancer_lock,child_expectEndpointWithSessionAffinityReset5113);
	child_expectEndpointWithSessionAffinityReset5113?0;
	run expectEndpointWithSessionAffinityReset51(loadBalancer_lock,child_expectEndpointWithSessionAffinityReset5114);
	child_expectEndpointWithSessionAffinityReset5114?0;
	stop_process: skip;
	child!0
}
proctype NextEndpoint136(Mutexdef lb_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	lb_lock.Lock!false;
	

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
		fi;
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
		lb_lock.Unlock!false;
	child!0
}
proctype NewService85(Mutexdef lb_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_newServiceInternal941 = [1] of {int};
	lb_lock.Lock!false;
	run newServiceInternal94(lb_lock,child_newServiceInternal941);
	child_newServiceInternal941?0;
	goto stop_process;
	stop_process: skip;
		lb_lock.Unlock!false;
	child!0
}
proctype newServiceInternal94(Mutexdef lb_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype OnEndpointsAdd223(Mutexdef lb_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_newServiceInternal942 = [1] of {int};
	chan child_newServiceInternal943 = [1] of {int};
	int portsToEndpoints = -2;
	lb_lock.Lock!false;
	

	if
	:: portsToEndpoints-1 != -3 -> 
				for(i : 0.. portsToEndpoints-1) {
			for10: skip;
			

			if
			:: true -> 
				run newServiceInternal94(lb_lock,child_newServiceInternal942);
				child_newServiceInternal942?0
			:: true;
			fi;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			

			if
			:: true -> 
				run newServiceInternal94(lb_lock,child_newServiceInternal943);
				child_newServiceInternal943?0
			:: true;
			fi;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	stop_process: skip;
		lb_lock.Unlock!false;
	child!0
}
proctype expectEndpointWithSessionAffinityReset51(Mutexdef loadBalancer_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NextEndpoint1366 = [1] of {int};
	run NextEndpoint136(loadBalancer_lock,child_NextEndpoint1366);
	child_NextEndpoint1366?0;
	stop_process: skip;
	child!0
}
proctype expectEndpoint41(Mutexdef loadBalancer_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NextEndpoint1369 = [1] of {int};
	run NextEndpoint136(loadBalancer_lock,child_NextEndpoint1369);
	child_NextEndpoint1369?0;
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype mutexMonitor(Mutexdef m) {
bool locked = false;
do
:: true ->
	if
	:: m.Counter > 0 ->
		if 
		:: m.RUnlock?false -> 
			m.Counter = m.Counter - 1;
		:: m.RLock?false -> 
			m.Counter = m.Counter + 1;
		fi;
	:: locked ->
		m.Unlock?false;
		locked = false;
	:: else ->	 end:	if
		:: m.Unlock?false ->
			assert(0==32);		:: m.Lock?false ->
			locked =true;
		:: m.RUnlock?false ->
			assert(0==32);		:: m.RLock?false ->
			m.Counter = m.Counter + 1;
		fi;
	fi;
od
}

