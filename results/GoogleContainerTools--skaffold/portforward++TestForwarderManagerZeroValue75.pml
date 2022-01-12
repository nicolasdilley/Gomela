// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/GoogleContainerTools/skaffold/blob//pkg/skaffold/kubernetes/portforward/forwarder_manager_test.go#L75
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestForwarderManagerZeroValue750 = [1] of {int};
	run TestForwarderManagerZeroValue75(child_TestForwarderManagerZeroValue750);
	run receiver(child_TestForwarderManagerZeroValue750)
stop_process:skip
}

proctype TestForwarderManagerZeroValue75(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Stop1591 = [1] of {int};
	chan child_Start1280 = [1] of {int};
	Mutexdef m_singleRun_mu;
	Mutexdef m_entryManager_forwardedResources_mu;
	Mutexdef m_entryManager_forwardedPorts_lock;
	run mutexMonitor(m_entryManager_forwardedPorts_lock);
	run mutexMonitor(m_entryManager_forwardedResources_mu);
	run mutexMonitor(m_singleRun_mu);
	run Start128(m_entryManager_forwardedPorts_lock,m_entryManager_forwardedResources_mu,m_singleRun_mu,child_Start1280);
	child_Start1280?0;
	run Stop159(m_entryManager_forwardedPorts_lock,m_entryManager_forwardedResources_mu,m_singleRun_mu,child_Stop1591);
	child_Stop1591?0;
	stop_process: skip;
	child!0
}
proctype Start128(Mutexdef p_entryManager_forwardedPorts_lock;Mutexdef p_entryManager_forwardedResources_mu;Mutexdef p_singleRun_mu;chan child) {
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
proctype Stop159(Mutexdef p_entryManager_forwardedPorts_lock;Mutexdef p_entryManager_forwardedResources_mu;Mutexdef p_singleRun_mu;chan child) {
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

