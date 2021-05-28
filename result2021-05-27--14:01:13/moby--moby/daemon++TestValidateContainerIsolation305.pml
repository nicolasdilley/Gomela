// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/moby/moby/blob/5a82cee6d499e51bc903a743e4f0f205adb161a9/daemon/daemon_test.go#L305
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestValidateContainerIsolation3050 = [1] of {int};
	run TestValidateContainerIsolation305(child_TestValidateContainerIsolation3050);
	run receiver(child_TestValidateContainerIsolation3050)
stop_process:skip
}

proctype TestValidateContainerIsolation305(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_verifyContainerSettings2340 = [1] of {int};
	Mutexdef d_mdDB_statlock;
	Mutexdef d_mdDB_mmaplock;
	Mutexdef d_mdDB_metalock;
	Mutexdef d_mdDB_rwlock;
	Mutexdef d_mdDB_batchMu;
	Mutexdef d_attachableNetworkLock_mu;
	Mutexdef d_containerdCli_connMu;
	Mutexdef d_linkIndex_mu;
	Mutexdef d_pluginManager_muGC;
	Mutexdef d_pluginManager_mu;
	Mutexdef d_EventsService_mu;
	Mutexdef d_statsCollector_m;
	run mutexMonitor(d_statsCollector_m);
	run mutexMonitor(d_EventsService_mu);
	run mutexMonitor(d_pluginManager_mu);
	run mutexMonitor(d_pluginManager_muGC);
	run mutexMonitor(d_linkIndex_mu);
	run mutexMonitor(d_containerdCli_connMu);
	run mutexMonitor(d_attachableNetworkLock_mu);
	run mutexMonitor(d_mdDB_batchMu);
	run mutexMonitor(d_mdDB_rwlock);
	run mutexMonitor(d_mdDB_metalock);
	run mutexMonitor(d_mdDB_mmaplock);
	run mutexMonitor(d_mdDB_statlock);
	run verifyContainerSettings234(d_attachableNetworkLock_mu,d_containerdCli_connMu,d_EventsService_mu,d_linkIndex_mu,d_mdDB_batchMu,d_mdDB_metalock,d_mdDB_mmaplock,d_mdDB_rwlock,d_mdDB_statlock,d_pluginManager_mu,d_pluginManager_muGC,d_statsCollector_m,child_verifyContainerSettings2340);
	child_verifyContainerSettings2340?0;
	stop_process: skip;
	child!0
}
proctype verifyContainerSettings234(Mutexdef daemon_attachableNetworkLock_mu;Mutexdef daemon_containerdCli_connMu;Mutexdef daemon_EventsService_mu;Mutexdef daemon_linkIndex_mu;Mutexdef daemon_mdDB_batchMu;Mutexdef daemon_mdDB_metalock;Mutexdef daemon_mdDB_mmaplock;Mutexdef daemon_mdDB_rwlock;Mutexdef daemon_mdDB_statlock;Mutexdef daemon_pluginManager_mu;Mutexdef daemon_pluginManager_muGC;Mutexdef daemon_statsCollector_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int warnings = -2; // opt warnings
	

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

