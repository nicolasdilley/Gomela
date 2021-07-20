// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/istio/istio/blob/9a5df21188426a6a7dd7d7503e01330a79db8a48/pilot/pkg/serviceregistry/aggregate/controller_test.go#L284
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestGetProxyWorkloadLabels2840 = [1] of {int};
	run TestGetProxyWorkloadLabels284(child_TestGetProxyWorkloadLabels2840);
	run receiver(child_TestGetProxyWorkloadLabels2840)
stop_process:skip
}

proctype TestGetProxyWorkloadLabels284(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetProxyWorkloadLabels2470 = [1] of {int};
	Mutexdef aggregateCtl_storeLock;
	run mutexMonitor(aggregateCtl_storeLock);
	run GetProxyWorkloadLabels247(aggregateCtl_storeLock,child_GetProxyWorkloadLabels2470);
	child_GetProxyWorkloadLabels2470?0;
	stop_process: skip;
	child!0
}
proctype GetProxyWorkloadLabels247(Mutexdef c_storeLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_c_GetRegistries__c_GetRegistries__ = -2; // opt var_c_GetRegistries__c_GetRegistries__
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

