// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/vault/blob/f8f289712a3d37115090591602a2b92503fb3a13/vault/activity_log_test.go#L1558
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestActivityLog_IncludeNamespace15580 = [1] of {int};
	run TestActivityLog_IncludeNamespace1558(child_TestActivityLog_IncludeNamespace15580);
	run receiver(child_TestActivityLog_IncludeNamespace15580)
stop_process:skip
}

proctype TestActivityLog_IncludeNamespace1558(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_includeInResponse13850 = [1] of {int};
	chan child_includeInResponse13851 = [1] of {int};
	Mutexdef a_view_readOnlyErrLock;
	Mutexdef a_fragmentLock;
	Mutexdef a_l;
	Mutexdef a_core_allLoggersLock;
	Mutexdef a_core_unsealWithStoredKeysLock;
	Mutexdef a_core_leaderParamsLock;
	Mutexdef a_core_requestForwardingConnectionLock;
	Mutexdef a_core_clusterParamsLock;
	Mutexdef a_core_reloadFuncsLock;
	Mutexdef a_core_metricsMutex;
	Mutexdef a_core_auditLock;
	Mutexdef a_core_authLock;
	Mutexdef a_core_mountsLock;
	Mutexdef a_core_rekeyLock;
	Mutexdef a_core_generateRootLock;
	int var_testCases = -2; // opt var_testCases
	run mutexMonitor(a_core_generateRootLock);
	run mutexMonitor(a_core_rekeyLock);
	run mutexMonitor(a_core_mountsLock);
	run mutexMonitor(a_core_authLock);
	run mutexMonitor(a_core_auditLock);
	run mutexMonitor(a_core_metricsMutex);
	run mutexMonitor(a_core_reloadFuncsLock);
	run mutexMonitor(a_core_clusterParamsLock);
	run mutexMonitor(a_core_requestForwardingConnectionLock);
	run mutexMonitor(a_core_leaderParamsLock);
	run mutexMonitor(a_core_unsealWithStoredKeysLock);
	run mutexMonitor(a_core_allLoggersLock);
	run mutexMonitor(a_l);
	run mutexMonitor(a_fragmentLock);
	run mutexMonitor(a_view_readOnlyErrLock);
	

	if
	:: var_testCases-1 != -3 -> 
				for(i : 0.. var_testCases-1) {
			for10: skip;
			run includeInResponse1385(a_core_allLoggersLock,a_core_auditLock,a_core_authLock,a_core_clusterParamsLock,a_core_generateRootLock,a_core_leaderParamsLock,a_core_metricsMutex,a_core_mountsLock,a_core_rekeyLock,a_core_reloadFuncsLock,a_core_requestForwardingConnectionLock,a_core_unsealWithStoredKeysLock,a_fragmentLock,a_l,a_view_readOnlyErrLock,child_includeInResponse13850);
			child_includeInResponse13850?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run includeInResponse1385(a_core_allLoggersLock,a_core_auditLock,a_core_authLock,a_core_clusterParamsLock,a_core_generateRootLock,a_core_leaderParamsLock,a_core_metricsMutex,a_core_mountsLock,a_core_rekeyLock,a_core_reloadFuncsLock,a_core_requestForwardingConnectionLock,a_core_unsealWithStoredKeysLock,a_fragmentLock,a_l,a_view_readOnlyErrLock,child_includeInResponse13851);
			child_includeInResponse13851?0;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype includeInResponse1385(Mutexdef a_core_allLoggersLock;Mutexdef a_core_auditLock;Mutexdef a_core_authLock;Mutexdef a_core_clusterParamsLock;Mutexdef a_core_generateRootLock;Mutexdef a_core_leaderParamsLock;Mutexdef a_core_metricsMutex;Mutexdef a_core_mountsLock;Mutexdef a_core_rekeyLock;Mutexdef a_core_reloadFuncsLock;Mutexdef a_core_requestForwardingConnectionLock;Mutexdef a_core_unsealWithStoredKeysLock;Mutexdef a_fragmentLock;Mutexdef a_l;Mutexdef a_view_readOnlyErrLock;chan child) {
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

proctype receiver(chan c) {
c?0
}

