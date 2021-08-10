// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/kubernetes/kubernetes/blob/0277cff2682d5a0d3c6fa2109f7f82e8db3f2ed8/pkg/proxy/userspace/roundrobin_test.go#L423
#define not_found_268  -2 // opt newEndpoints line 205
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestStickyLoadBalanaceWorksWithMultipleEndpointsRemoveOne4230 = [1] of {int};
	run TestStickyLoadBalanaceWorksWithMultipleEndpointsRemoveOne423(child_TestStickyLoadBalanaceWorksWithMultipleEndpointsRemoveOne4230);
	run receiver(child_TestStickyLoadBalanaceWorksWithMultipleEndpointsRemoveOne4230)
stop_process:skip
}

proctype TestStickyLoadBalanaceWorksWithMultipleEndpointsRemoveOne423(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_expectEndpoint4118 = [1] of {int};
	chan child_expectEndpoint4117 = [1] of {int};
	chan child_expectEndpoint4116 = [1] of {int};
	chan child_expectEndpoint4115 = [1] of {int};
	chan child_expectEndpoint4114 = [1] of {int};
	chan child_expectEndpoint4113 = [1] of {int};
	chan child_OnEndpointsUpdate24812 = [1] of {int};
	chan child_expectEndpoint4111 = [1] of {int};
	chan child_expectEndpoint4110 = [1] of {int};
	chan child_expectEndpoint419 = [1] of {int};
	chan child_OnEndpointsUpdate2488 = [1] of {int};
	chan child_expectEndpoint417 = [1] of {int};
	chan child_expectEndpoint416 = [1] of {int};
	chan child_expectEndpoint415 = [1] of {int};
	chan child_expectEndpoint414 = [1] of {int};
	chan child_expectEndpoint413 = [1] of {int};
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
	run expectEndpoint41(loadBalancer_lock,child_expectEndpoint413);
	child_expectEndpoint413?0;
	run expectEndpoint41(loadBalancer_lock,child_expectEndpoint414);
	child_expectEndpoint414?0;
	run expectEndpoint41(loadBalancer_lock,child_expectEndpoint415);
	child_expectEndpoint415?0;
	run expectEndpoint41(loadBalancer_lock,child_expectEndpoint416);
	child_expectEndpoint416?0;
	run expectEndpoint41(loadBalancer_lock,child_expectEndpoint417);
	child_expectEndpoint417?0;
	run OnEndpointsUpdate248(loadBalancer_lock,child_OnEndpointsUpdate2488);
	child_OnEndpointsUpdate2488?0;
	run expectEndpoint41(loadBalancer_lock,child_expectEndpoint419);
	child_expectEndpoint419?0;
	run expectEndpoint41(loadBalancer_lock,child_expectEndpoint4110);
	child_expectEndpoint4110?0;
	run expectEndpoint41(loadBalancer_lock,child_expectEndpoint4111);
	child_expectEndpoint4111?0;
	run OnEndpointsUpdate248(loadBalancer_lock,child_OnEndpointsUpdate24812);
	child_OnEndpointsUpdate24812?0;
	run expectEndpoint41(loadBalancer_lock,child_expectEndpoint4113);
	child_expectEndpoint4113?0;
	run expectEndpoint41(loadBalancer_lock,child_expectEndpoint4114);
	child_expectEndpoint4114?0;
	run expectEndpoint41(loadBalancer_lock,child_expectEndpoint4115);
	child_expectEndpoint4115?0;
	run expectEndpoint41(loadBalancer_lock,child_expectEndpoint4116);
	child_expectEndpoint4116?0;
	run expectEndpoint41(loadBalancer_lock,child_expectEndpoint4117);
	child_expectEndpoint4117?0;
	run expectEndpoint41(loadBalancer_lock,child_expectEndpoint4118);
	child_expectEndpoint4118?0;
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
proctype NewService85(Mutexdef lb_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_newServiceInternal941 = [1] of {int};
	lb_lock.Lock!false;
	run newServiceInternal94(lb_lock,child_newServiceInternal941);
	child_newServiceInternal941?0;
	goto defer1;
		defer1: skip;
	lb_lock.Unlock!false;
	stop_process: skip;
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
	int var_portsToEndpoints = -2; // opt var_portsToEndpoints
	lb_lock.Lock!false;
	

	if
	:: var_portsToEndpoints-1 != -3 -> 
				for(i : 0.. var_portsToEndpoints-1) {
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
		defer1: skip;
	lb_lock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype expectEndpoint41(Mutexdef loadBalancer_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NextEndpoint1363 = [1] of {int};
	run NextEndpoint136(loadBalancer_lock,child_NextEndpoint1363);
	child_NextEndpoint1363?0;
	stop_process: skip;
	child!0
}
proctype OnEndpointsUpdate248(Mutexdef lb_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_resetService29112 = [1] of {int};
	chan child_resetService29113 = [1] of {int};
	chan child_newServiceInternal949 = [1] of {int};
	chan child_removeStaleAffinity2058 = [1] of {int};
	chan child_newServiceInternal9411 = [1] of {int};
	chan child_removeStaleAffinity20510 = [1] of {int};
	int var_oldPortsToEndpoints = -2; // opt var_oldPortsToEndpoints
	int var_portsToEndpoints = -2; // opt var_portsToEndpoints
	lb_lock.Lock!false;
	

	if
	:: var_portsToEndpoints-1 != -3 -> 
				for(i : 0.. var_portsToEndpoints-1) {
			for20: skip;
			

			if
			:: true -> 
				run removeStaleAffinity205(lb_lock,not_found_268,child_removeStaleAffinity2058);
				child_removeStaleAffinity2058?0;
				run newServiceInternal94(lb_lock,child_newServiceInternal949);
				child_newServiceInternal949?0
			:: true;
			fi;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for25: skip;
			

			if
			:: true -> 
				run removeStaleAffinity205(lb_lock,not_found_268,child_removeStaleAffinity20510);
				child_removeStaleAffinity20510?0;
				run newServiceInternal94(lb_lock,child_newServiceInternal9411);
				child_newServiceInternal9411?0
			:: true;
			fi;
			for25_end: skip
		:: true -> 
			break
		od;
		for25_exit: skip
	fi;
	

	if
	:: var_oldPortsToEndpoints-1 != -3 -> 
				for(i : 0.. var_oldPortsToEndpoints-1) {
			for30: skip;
			

			if
			:: true -> 
				run resetService291(lb_lock,child_resetService29112);
				child_resetService29112?0
			:: true;
			fi;
			for30_end: skip
		};
		for30_exit: skip
	:: else -> 
		do
		:: true -> 
			for31: skip;
			

			if
			:: true -> 
				run resetService291(lb_lock,child_resetService29113);
				child_resetService29113?0
			:: true;
			fi;
			for31_end: skip
		:: true -> 
			break
		od;
		for31_exit: skip
	fi;
		defer1: skip;
	lb_lock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype removeStaleAffinity205(Mutexdef lb_lock;int var_newEndpoints;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_state_endpoints = -2; // opt var_state_endpoints
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype resetService291(Mutexdef lb_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

