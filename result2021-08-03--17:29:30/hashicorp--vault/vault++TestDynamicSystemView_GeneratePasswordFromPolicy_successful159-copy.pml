// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/vault/blob/f8f289712a3d37115090591602a2b92503fb3a13/vault/dynamic_system_view_test.go#L159
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestDynamicSystemView_GeneratePasswordFromPolicy_successful1590 = [1] of {int};
	run TestDynamicSystemView_GeneratePasswordFromPolicy_successful159(child_TestDynamicSystemView_GeneratePasswordFromPolicy_successful1590);
	run receiver(child_TestDynamicSystemView_GeneratePasswordFromPolicy_successful1590)
stop_process:skip
}

proctype TestDynamicSystemView_GeneratePasswordFromPolicy_successful159(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GeneratePasswordFromPolicy3321 = [1] of {int};
	chan child_GeneratePasswordFromPolicy3320 = [1] of {int};
	Mutexdef dsv_core_allLoggersLock;
	Mutexdef dsv_core_unsealWithStoredKeysLock;
	Mutexdef dsv_core_leaderParamsLock;
	Mutexdef dsv_core_requestForwardingConnectionLock;
	Mutexdef dsv_core_clusterParamsLock;
	Mutexdef dsv_core_reloadFuncsLock;
	Mutexdef dsv_core_metricsMutex;
	Mutexdef dsv_core_auditLock;
	Mutexdef dsv_core_authLock;
	Mutexdef dsv_core_mountsLock;
	Mutexdef dsv_core_rekeyLock;
	Mutexdef dsv_core_generateRootLock;
	int var_actual = -2; // opt var_actual
	run mutexMonitor(dsv_core_generateRootLock);
	run mutexMonitor(dsv_core_rekeyLock);
	run mutexMonitor(dsv_core_mountsLock);
	run mutexMonitor(dsv_core_authLock);
	run mutexMonitor(dsv_core_auditLock);
	run mutexMonitor(dsv_core_metricsMutex);
	run mutexMonitor(dsv_core_reloadFuncsLock);
	run mutexMonitor(dsv_core_clusterParamsLock);
	run mutexMonitor(dsv_core_requestForwardingConnectionLock);
	run mutexMonitor(dsv_core_leaderParamsLock);
	run mutexMonitor(dsv_core_unsealWithStoredKeysLock);
	run mutexMonitor(dsv_core_allLoggersLock);
	

	if
	:: 0 != -2 && 100-1 != -3 -> 
				for(i : 0.. 100-1) {
			for13: skip;
			run GeneratePasswordFromPolicy332(dsv_core_allLoggersLock,dsv_core_auditLock,dsv_core_authLock,dsv_core_clusterParamsLock,dsv_core_generateRootLock,dsv_core_leaderParamsLock,dsv_core_metricsMutex,dsv_core_mountsLock,dsv_core_rekeyLock,dsv_core_reloadFuncsLock,dsv_core_requestForwardingConnectionLock,dsv_core_unsealWithStoredKeysLock,child_GeneratePasswordFromPolicy3321);
			child_GeneratePasswordFromPolicy3321?0;
			for13_end: skip
		};
		for13_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run GeneratePasswordFromPolicy332(dsv_core_allLoggersLock,dsv_core_auditLock,dsv_core_authLock,dsv_core_clusterParamsLock,dsv_core_generateRootLock,dsv_core_leaderParamsLock,dsv_core_metricsMutex,dsv_core_mountsLock,dsv_core_rekeyLock,dsv_core_reloadFuncsLock,dsv_core_requestForwardingConnectionLock,dsv_core_unsealWithStoredKeysLock,child_GeneratePasswordFromPolicy3320);
			child_GeneratePasswordFromPolicy3320?0;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype GeneratePasswordFromPolicy332(Mutexdef d_core_allLoggersLock;Mutexdef d_core_auditLock;Mutexdef d_core_authLock;Mutexdef d_core_clusterParamsLock;Mutexdef d_core_generateRootLock;Mutexdef d_core_leaderParamsLock;Mutexdef d_core_metricsMutex;Mutexdef d_core_mountsLock;Mutexdef d_core_rekeyLock;Mutexdef d_core_reloadFuncsLock;Mutexdef d_core_requestForwardingConnectionLock;Mutexdef d_core_unsealWithStoredKeysLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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
		goto stop_process
	:: true;
	fi;
	

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

proctype receiver(chan c) {
c?0
}

