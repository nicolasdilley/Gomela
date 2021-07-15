#define not_found_227  -2

// https://github.com/kubernetes/kubernetes/blob/master/pkg/proxy/winuserspace/roundrobin_test.go#L559
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestStickyLoadBalanceWorksWithServiceRemoval5590 = [1] of {int};
	run TestStickyLoadBalanceWorksWithServiceRemoval559(child_TestStickyLoadBalanceWorksWithServiceRemoval5590)
stop_process:skip
}

proctype TestStickyLoadBalanceWorksWithServiceRemoval559(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_expectEndpoint4127 = [1] of {int};
	chan child_expectEndpoint4126 = [1] of {int};
	chan child_expectEndpoint4125 = [1] of {int};
	chan child_expectEndpoint4124 = [1] of {int};
	chan child_expectEndpoint4123 = [1] of {int};
	chan child_expectEndpoint4122 = [1] of {int};
	chan child_NextEndpoint12521 = [1] of {int};
	chan child_OnEndpointsDelete28820 = [1] of {int};
	chan child_expectEndpoint4119 = [1] of {int};
	chan child_expectEndpoint4118 = [1] of {int};
	chan child_expectEndpoint4117 = [1] of {int};
	chan child_expectEndpoint4116 = [1] of {int};
	chan child_expectEndpoint4115 = [1] of {int};
	chan child_expectEndpoint4114 = [1] of {int};
	chan child_expectEndpoint4113 = [1] of {int};
	chan child_expectEndpoint4112 = [1] of {int};
	chan child_expectEndpoint4111 = [1] of {int};
	chan child_expectEndpoint4110 = [1] of {int};
	chan child_expectEndpoint419 = [1] of {int};
	chan child_expectEndpoint418 = [1] of {int};
	chan child_expectEndpoint417 = [1] of {int};
	chan child_expectEndpoint416 = [1] of {int};
	chan child_expectEndpoint415 = [1] of {int};
	chan child_OnEndpointsAdd2144 = [1] of {int};
	chan child_OnEndpointsAdd2143 = [1] of {int};
	chan child_NewService842 = [1] of {int};
	chan child_NewService841 = [1] of {int};
	chan child_NextEndpoint1250 = [1] of {int};
	Mutexdef loadBalancer_lock;
	run mutexMonitor(loadBalancer_lock);
	run NextEndpoint125(loadBalancer_lock,child_NextEndpoint1250);
	child_NextEndpoint1250?0;
	run NewService84(loadBalancer_lock,child_NewService841);
	child_NewService841?0;
	run NewService84(loadBalancer_lock,child_NewService842);
	child_NewService842?0;
	run OnEndpointsAdd214(loadBalancer_lock,child_OnEndpointsAdd2143);
	child_OnEndpointsAdd2143?0;
	run OnEndpointsAdd214(loadBalancer_lock,child_OnEndpointsAdd2144);
	child_OnEndpointsAdd2144?0;
	run expectEndpoint41(loadBalancer_lock,child_expectEndpoint415);
	child_expectEndpoint415?0;
	run expectEndpoint41(loadBalancer_lock,child_expectEndpoint416);
	child_expectEndpoint416?0;
	run expectEndpoint41(loadBalancer_lock,child_expectEndpoint417);
	child_expectEndpoint417?0;
	run expectEndpoint41(loadBalancer_lock,child_expectEndpoint418);
	child_expectEndpoint418?0;
	run expectEndpoint41(loadBalancer_lock,child_expectEndpoint419);
	child_expectEndpoint419?0;
	run expectEndpoint41(loadBalancer_lock,child_expectEndpoint4110);
	child_expectEndpoint4110?0;
	run expectEndpoint41(loadBalancer_lock,child_expectEndpoint4111);
	child_expectEndpoint4111?0;
	run expectEndpoint41(loadBalancer_lock,child_expectEndpoint4112);
	child_expectEndpoint4112?0;
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
	run expectEndpoint41(loadBalancer_lock,child_expectEndpoint4119);
	child_expectEndpoint4119?0;
	run OnEndpointsDelete288(loadBalancer_lock,child_OnEndpointsDelete28820);
	child_OnEndpointsDelete28820?0;
	run NextEndpoint125(loadBalancer_lock,child_NextEndpoint12521);
	child_NextEndpoint12521?0;
	run expectEndpoint41(loadBalancer_lock,child_expectEndpoint4122);
	child_expectEndpoint4122?0;
	run expectEndpoint41(loadBalancer_lock,child_expectEndpoint4123);
	child_expectEndpoint4123?0;
	run expectEndpoint41(loadBalancer_lock,child_expectEndpoint4124);
	child_expectEndpoint4124?0;
	run expectEndpoint41(loadBalancer_lock,child_expectEndpoint4125);
	child_expectEndpoint4125?0;
	run expectEndpoint41(loadBalancer_lock,child_expectEndpoint4126);
	child_expectEndpoint4126?0;
	run expectEndpoint41(loadBalancer_lock,child_expectEndpoint4127);
	child_expectEndpoint4127?0;
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
	chan child_newServiceInternal934 = [1] of {int};
	chan child_updateAffinityMap1943 = [1] of {int};
	chan child_newServiceInternal936 = [1] of {int};
	chan child_updateAffinityMap1945 = [1] of {int};
	int portsToEndpoints = -2;
	lb_lock.Lock!false;
	

	if
	:: portsToEndpoints-1 != -3 -> 
				for(i : 0.. portsToEndpoints-1) {
			for10: skip;
			

			if
			:: true -> 
				run updateAffinityMap194(lb_lock,not_found_227,child_updateAffinityMap1943);
				child_updateAffinityMap1943?0;
				run newServiceInternal93(lb_lock,child_newServiceInternal934);
				child_newServiceInternal934?0
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
				run updateAffinityMap194(lb_lock,not_found_227,child_updateAffinityMap1945);
				child_updateAffinityMap1945?0;
				run newServiceInternal93(lb_lock,child_newServiceInternal936);
				child_newServiceInternal936?0
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
proctype expectEndpoint41(Mutexdef loadBalancer_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NextEndpoint1255 = [1] of {int};
	run NextEndpoint125(loadBalancer_lock,child_NextEndpoint1255);
	child_NextEndpoint1255?0;
	stop_process: skip;
	child!0
}
proctype OnEndpointsDelete288(Mutexdef lb_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	lb_lock.Lock!false;
	stop_process: skip;
		lb_lock.Unlock!false;
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

