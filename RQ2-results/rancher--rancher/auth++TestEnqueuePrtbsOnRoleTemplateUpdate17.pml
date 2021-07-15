
// https://github.com/rancher/rancher/blob/master/pkg/controllers/management/auth/role_template_lifecycle_test.go#L17
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestEnqueuePrtbsOnRoleTemplateUpdate170 = [1] of {int};
	run TestEnqueuePrtbsOnRoleTemplateUpdate17(child_TestEnqueuePrtbsOnRoleTemplateUpdate170)
stop_process:skip
}

proctype TestEnqueuePrtbsOnRoleTemplateUpdate17(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_enqueuePrtbs1130 = [1] of {int};
	Mutexdef rtl_clusterManager_startSem_mu;
	Mutexdef rtl_clusterManager_controllers_mu;
	run mutexMonitor(rtl_clusterManager_controllers_mu);
	run mutexMonitor(rtl_clusterManager_startSem_mu);
	run enqueuePrtbs113(rtl_clusterManager_controllers_mu,rtl_clusterManager_startSem_mu,child_enqueuePrtbs1130);
	child_enqueuePrtbs1130?0;
	stop_process: skip;
	child!0
}
proctype enqueuePrtbs113(Mutexdef rtl_clusterManager_controllers_mu;Mutexdef rtl_clusterManager_startSem_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

