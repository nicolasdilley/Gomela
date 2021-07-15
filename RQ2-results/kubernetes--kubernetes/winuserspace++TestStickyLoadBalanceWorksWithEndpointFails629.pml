#define not_found_227  -2

// https://github.com/kubernetes/kubernetes/blob/master/pkg/proxy/winuserspace/roundrobin_test.go#L629
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
	chan child_NextEndpoint1255 = [1] of {int};
	chan child_NextEndpoint1254 = [1] of {int};
	chan child_NextEndpoint1253 = [1] of {int};
	chan child_OnEndpointsAdd2142 = [1] of {int};
	chan child_NewService841 = [1] of {int};
	chan child_NextEndpoint1250 = [1] of {int};
	Mutexdef loadBalancer_lock;
	run mutexMonitor(loadBalancer_lock);
	run NextEndpoint125(loadBalancer_lock,child_NextEndpoint1250);
	child_NextEndpoint1250?0;
	run NewService84(loadBalancer_lock,child_NewService841);
	child_NewService841?0;
	run OnEndpointsAdd214(loadBalancer_lock,child_OnEndpointsAdd2142);
	child_OnEndpointsAdd2142?0;
	run NextEndpoint125(loadBalancer_lock,child_NextEndpoint1253);
	child_NextEndpoint1253?0;
	run NextEndpoint125(loadBalancer_lock,child_NextEndpoint1254);
	child_NextEndpoint1254?0;
	run NextEndpoint125(loadBalancer_lock,child_NextEndpoint1255);
	child_NextEndpoint1255?0;
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
proctype NextEndpoint125(Mutexdef lb_lock;chan child) {
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
proctype NewService84(Mutexdef lb_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_newServiceInternal931 = [1] of {int};
	lb_lock.Lock!false;
	run newServiceInternal93(lb_lock,child_newServiceInternal931);
	child_newServiceInternal931?0;
	goto stop_process;
	stop_process: skip;
		lb_lock.Unlock!false;
	child!0
}
proctype newServiceInternal93(Mutexdef lb_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype OnEndpointsAdd214(Mutexdef lb_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_newServiceInternal933 = [1] of {int};
	chan child_updateAffinityMap1942 = [1] of {int};
	chan child_newServiceInternal935 = [1] of {int};
	chan child_updateAffinityMap1944 = [1] of {int};
	int portsToEndpoints = -2;
	lb_lock.Lock!false;
	

	if
	:: portsToEndpoints-1 != -3 -> 
				for(i : 0.. portsToEndpoints-1) {
			for10: skip;
			

			if
			:: true -> 
				run updateAffinityMap194(lb_lock,not_found_227,child_updateAffinityMap1942);
				child_updateAffinityMap1942?0;
				run newServiceInternal93(lb_lock,child_newServiceInternal933);
				child_newServiceInternal933?0
			:: true;
			fi;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for17: skip;
			

			if
			:: true -> 
				run updateAffinityMap194(lb_lock,not_found_227,child_updateAffinityMap1944);
				child_updateAffinityMap1944?0;
				run newServiceInternal93(lb_lock,child_newServiceInternal935);
				child_newServiceInternal935?0
			:: true;
			fi;
			for17_end: skip
		:: true -> 
			break
		od;
		for17_exit: skip
	fi;
	stop_process: skip;
		lb_lock.Unlock!false;
	child!0
}
proctype updateAffinityMap194(Mutexdef lb_lock;int newEndpoints;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype expectEndpointWithSessionAffinityReset51(Mutexdef loadBalancer_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NextEndpoint1256 = [1] of {int};
	run NextEndpoint125(loadBalancer_lock,child_NextEndpoint1256);
	child_NextEndpoint1256?0;
	stop_process: skip;
	child!0
}
proctype expectEndpoint41(Mutexdef loadBalancer_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NextEndpoint1259 = [1] of {int};
	run NextEndpoint125(loadBalancer_lock,child_NextEndpoint1259);
	child_NextEndpoint1259?0;
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

