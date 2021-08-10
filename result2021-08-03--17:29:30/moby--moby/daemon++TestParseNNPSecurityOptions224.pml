// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/moby/moby/blob/5a82cee6d499e51bc903a743e4f0f205adb161a9/daemon/daemon_unix_test.go#L224
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestParseNNPSecurityOptions2240 = [1] of {int};
	run TestParseNNPSecurityOptions224(child_TestParseNNPSecurityOptions2240);
	run receiver(child_TestParseNNPSecurityOptions2240)
stop_process:skip
}

proctype TestParseNNPSecurityOptions224(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef ctr_attachContext_mu;
	Wgdef ctr_LogCopier_copyJobs;
	Wgdef ctr_StreamConfig_wg;
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
	run wgMonitor(ctr_StreamConfig_wg);
	run wgMonitor(ctr_LogCopier_copyJobs);
	run mutexMonitor(ctr_attachContext_mu);
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

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

