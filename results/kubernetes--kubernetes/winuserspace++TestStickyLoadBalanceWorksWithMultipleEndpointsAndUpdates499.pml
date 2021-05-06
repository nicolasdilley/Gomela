#define not_found_227  -2
#define not_found_261  -2

// https://github.com/kubernetes/kubernetes/blob/master/pkg/proxy/winuserspace/roundrobin_test.go#L499
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestStickyLoadBalanceWorksWithMultipleEndpointsAndUpdates4990 = [1] of {int};
	run TestStickyLoadBalanceWorksWithMultipleEndpointsAndUpdates499(child_TestStickyLoadBalanceWorksWithMultipleEndpointsAndUpdates4990)
stop_process:skip
}

proctype TestStickyLoadBalanceWorksWithMultipleEndpointsAndUpdates499(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NextEndpoint12518 = [1] of {int};
	chan child_OnEndpointsUpdate24117 = [1] of {int};
	chan child_expectEndpoint4116 = [1] of {int};
	chan child_expectEndpoint4115 = [1] of {int};
	chan child_expectEndpoint4114 = [1] of {int};
	chan child_expectEndpoint4113 = [1] of {int};
	chan child_expectEndpoint4112 = [1] of {int};
	chan child_expectEndpoint4111 = [1] of {int};
	chan child_OnEndpointsUpdate24110 = [1] of {int};
	chan child_expectEndpoint419 = [1] of {int};
	chan child_expectEndpoint418 = [1] of {int};
	chan child_expectEndpoint417 = [1] of {int};
	chan child_expectEndpoint416 = [1] of {int};
	chan child_expectEndpoint415 = [1] of {int};
	chan child_expectEndpoint414 = [1] of {int};
	chan child_expectEndpoint413 = [1] of {int};
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
	run expectEndpoint41(loadBalancer_lock,child_expectEndpoint418);
	child_expectEndpoint418?0;
	run expectEndpoint41(loadBalancer_lock,child_expectEndpoint419);
	child_expectEndpoint419?0;
	run OnEndpointsUpdate241(loadBalancer_lock,child_OnEndpointsUpdate24110);
	child_OnEndpointsUpdate24110?0;
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
	run OnEndpointsUpdate241(loadBalancer_lock,child_OnEndpointsUpdate24117);
	child_OnEndpointsUpdate24117?0;
	run NextEndpoint125(loadBalancer_lock,child_NextEndpoint12518);
	child_NextEndpoint12518?0;
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
proctype expectEndpoint41(Mutexdef loadBalancer_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NextEndpoint1253 = [1] of {int};
	run NextEndpoint125(loadBalancer_lock,child_NextEndpoint1253);
	child_NextEndpoint1253?0;
	stop_process: skip;
	child!0
}
proctype OnEndpointsUpdate241(Mutexdef lb_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_newServiceInternal9311 = [1] of {int};
	chan child_updateAffinityMap19410 = [1] of {int};
	chan child_newServiceInternal9313 = [1] of {int};
	chan child_updateAffinityMap19412 = [1] of {int};
	int portsToEndpoints = -2;
	lb_lock.Lock!false;
	

	if
	:: portsToEndpoints-1 != -3 -> 
				for(i : 0.. portsToEndpoints-1) {
			for20: skip;
			

			if
			:: true -> 
				run updateAffinityMap194(lb_lock,not_found_261,child_updateAffinityMap19410);
				child_updateAffinityMap19410?0;
				run newServiceInternal93(lb_lock,child_newServiceInternal9311);
				child_newServiceInternal9311?0
			:: true;
			fi;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for21: skip;
			

			if
			:: true -> 
				run updateAffinityMap194(lb_lock,not_found_261,child_updateAffinityMap19412);
				child_updateAffinityMap19412?0;
				run newServiceInternal93(lb_lock,child_newServiceInternal9313);
				child_newServiceInternal9313?0
			:: true;
			fi;
			for21_end: skip
		:: true -> 
			break
		od;
		for21_exit: skip
	fi;
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

