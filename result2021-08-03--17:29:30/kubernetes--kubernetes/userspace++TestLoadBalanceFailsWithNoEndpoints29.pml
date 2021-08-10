// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kubernetes/blob/0277cff2682d5a0d3c6fa2109f7f82e8db3f2ed8/pkg/proxy/userspace/roundrobin_test.go#L29
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestLoadBalanceFailsWithNoEndpoints290 = [1] of {int};
	run TestLoadBalanceFailsWithNoEndpoints29(child_TestLoadBalanceFailsWithNoEndpoints290);
	run receiver(child_TestLoadBalanceFailsWithNoEndpoints290)
stop_process:skip
}

proctype TestLoadBalanceFailsWithNoEndpoints29(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NextEndpoint1360 = [1] of {int};
	Mutexdef loadBalancer_lock;
	run mutexMonitor(loadBalancer_lock);
	run NextEndpoint136(loadBalancer_lock,child_NextEndpoint1360);
	child_NextEndpoint1360?0;
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
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto defer1
		:: true;
		fi;
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto defer1
			:: true;
			fi
		:: true;
		fi
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	lb_lock.Unlock!false;
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

proctype receiver(chan c) {
c?0
}

