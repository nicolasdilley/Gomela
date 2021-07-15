
// https://github.com/istio/istio/blob/master/pilot/pkg/serviceregistry/aggregate/controller_test.go#L295
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestGetProxyServiceInstancesError2950 = [1] of {int};
	run TestGetProxyServiceInstancesError295(child_TestGetProxyServiceInstancesError2950)
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

