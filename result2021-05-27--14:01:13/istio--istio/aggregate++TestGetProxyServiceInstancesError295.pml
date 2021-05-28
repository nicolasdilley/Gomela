// num_comm_params=2
// num_mand_comm_params=0
// num_opt_comm_params=2

// git_link=https://github.com/istio/istio/blob/9a5df21188426a6a7dd7d7503e01330a79db8a48/pilot/pkg/serviceregistry/aggregate/controller_test.go#L295
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestGetProxyServiceInstancesError2950 = [1] of {int};
	run TestGetProxyServiceInstancesError295(child_TestGetProxyServiceInstancesError2950);
	run receiver(child_TestGetProxyServiceInstancesError2950)
stop_process:skip
}

proctype TestGetProxyServiceInstancesError295(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetProxyServiceInstances2281 = [1] of {int};
	chan child_GetProxyServiceInstances2280 = [1] of {int};
	Mutexdef aggregateCtl_storeLock;
	int instances = -2; // opt instances
	run mutexMonitor(aggregateCtl_storeLock);
	run GetProxyServiceInstances228(aggregateCtl_storeLock,child_GetProxyServiceInstances2280);
	child_GetProxyServiceInstances2280?0;
	run GetProxyServiceInstances228(aggregateCtl_storeLock,child_GetProxyServiceInstances2281);
	child_GetProxyServiceInstances2281?0;
	stop_process: skip;
	child!0
}
proctype GetProxyServiceInstances228(Mutexdef c_storeLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int c_GetRegistries__ = -2; // opt c_GetRegistries__
	goto stop_process;
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

