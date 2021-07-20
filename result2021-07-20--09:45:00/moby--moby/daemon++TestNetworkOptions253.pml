// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/moby/moby/blob/5a82cee6d499e51bc903a743e4f0f205adb161a9/daemon/daemon_unix_test.go#L253
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestNetworkOptions2530 = [1] of {int};
	run TestNetworkOptions253(child_TestNetworkOptions2530);
	run receiver(child_TestNetworkOptions2530)
stop_process:skip
}

proctype TestNetworkOptions253(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_networkOptions14371 = [1] of {int};
	chan child_networkOptions14370 = [1] of {int};
	Mutexdef daemon_mdDB_statlock;
	Mutexdef daemon_mdDB_mmaplock;
	Mutexdef daemon_mdDB_metalock;
	Mutexdef daemon_mdDB_rwlock;
	Mutexdef daemon_mdDB_batchMu;
	Mutexdef daemon_attachableNetworkLock_mu;
	Mutexdef daemon_containerdCli_connMu;
	Mutexdef daemon_linkIndex_mu;
	Mutexdef daemon_pluginManager_muGC;
	Mutexdef daemon_pluginManager_mu;
	Mutexdef daemon_EventsService_mu;
	Mutexdef daemon_statsCollector_m;
	run mutexMonitor(daemon_statsCollector_m);
	run mutexMonitor(daemon_EventsService_mu);
	run mutexMonitor(daemon_pluginManager_mu);
	run mutexMonitor(daemon_pluginManager_muGC);
	run mutexMonitor(daemon_linkIndex_mu);
	run mutexMonitor(daemon_containerdCli_connMu);
	run mutexMonitor(daemon_attachableNetworkLock_mu);
	run mutexMonitor(daemon_mdDB_batchMu);
	run mutexMonitor(daemon_mdDB_rwlock);
	run mutexMonitor(daemon_mdDB_metalock);
	run mutexMonitor(daemon_mdDB_mmaplock);
	run mutexMonitor(daemon_mdDB_statlock);
	run networkOptions1437(daemon_attachableNetworkLock_mu,daemon_containerdCli_connMu,daemon_EventsService_mu,daemon_linkIndex_mu,daemon_mdDB_batchMu,daemon_mdDB_metalock,daemon_mdDB_mmaplock,daemon_mdDB_rwlock,daemon_mdDB_statlock,daemon_pluginManager_mu,daemon_pluginManager_muGC,daemon_statsCollector_m,child_networkOptions14370);
	child_networkOptions14370?0;
	run networkOptions1437(daemon_attachableNetworkLock_mu,daemon_containerdCli_connMu,daemon_EventsService_mu,daemon_linkIndex_mu,daemon_mdDB_batchMu,daemon_mdDB_metalock,daemon_mdDB_mmaplock,daemon_mdDB_rwlock,daemon_mdDB_statlock,daemon_pluginManager_mu,daemon_pluginManager_muGC,daemon_statsCollector_m,child_networkOptions14371);
	child_networkOptions14371?0;
	stop_process: skip;
	child!0
}
proctype networkOptions1437(Mutexdef daemon_attachableNetworkLock_mu;Mutexdef daemon_containerdCli_connMu;Mutexdef daemon_EventsService_mu;Mutexdef daemon_linkIndex_mu;Mutexdef daemon_mdDB_batchMu;Mutexdef daemon_mdDB_metalock;Mutexdef daemon_mdDB_mmaplock;Mutexdef daemon_mdDB_rwlock;Mutexdef daemon_mdDB_statlock;Mutexdef daemon_pluginManager_mu;Mutexdef daemon_pluginManager_muGC;Mutexdef daemon_statsCollector_m;chan child) {
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
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
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

