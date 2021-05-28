// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/moby/moby/blob/5a82cee6d499e51bc903a743e4f0f205adb161a9/daemon/inspect_test.go#L14
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
	chan child_TestGetInspectData140 = [1] of {int};
	run TestGetInspectData14(child_TestGetInspectData140);
	run receiver(child_TestGetInspectData140)
stop_process:skip
}

proctype TestGetInspectData14(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getInspectData1271 = [1] of {int};
	chan child_getInspectData1270 = [1] of {int};
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
	Mutexdef c_attachContext_mu;
	Wgdef c_LogCopier_copyJobs;
	Wgdef c_StreamConfig_wg;
	run wgMonitor(c_StreamConfig_wg);
	run wgMonitor(c_LogCopier_copyJobs);
	run mutexMonitor(c_attachContext_mu);
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
	run getInspectData127(d_attachableNetworkLock_mu,d_containerdCli_connMu,d_EventsService_mu,d_linkIndex_mu,d_mdDB_batchMu,d_mdDB_metalock,d_mdDB_mmaplock,d_mdDB_rwlock,d_mdDB_statlock,d_pluginManager_mu,d_pluginManager_muGC,d_statsCollector_m,c_LogCopier_copyJobs,c_StreamConfig_wg,c_attachContext_mu,child_getInspectData1270);
	child_getInspectData1270?0;
	run getInspectData127(d_attachableNetworkLock_mu,d_containerdCli_connMu,d_EventsService_mu,d_linkIndex_mu,d_mdDB_batchMu,d_mdDB_metalock,d_mdDB_mmaplock,d_mdDB_rwlock,d_mdDB_statlock,d_pluginManager_mu,d_pluginManager_muGC,d_statsCollector_m,c_LogCopier_copyJobs,c_StreamConfig_wg,c_attachContext_mu,child_getInspectData1271);
	child_getInspectData1271?0;
	stop_process: skip;
	child!0
}
proctype getInspectData127(Mutexdef daemon_attachableNetworkLock_mu;Mutexdef daemon_containerdCli_connMu;Mutexdef daemon_EventsService_mu;Mutexdef daemon_linkIndex_mu;Mutexdef daemon_mdDB_batchMu;Mutexdef daemon_mdDB_metalock;Mutexdef daemon_mdDB_mmaplock;Mutexdef daemon_mdDB_rwlock;Mutexdef daemon_mdDB_statlock;Mutexdef daemon_pluginManager_mu;Mutexdef daemon_pluginManager_muGC;Mutexdef daemon_statsCollector_m;Wgdef container_LogCopier_copyJobs;Wgdef container_StreamConfig_wg;Mutexdef container_attachContext_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_children6660 = [1] of {int};
	int children = -2; // opt children
	run children666(daemon_attachableNetworkLock_mu,daemon_containerdCli_connMu,daemon_EventsService_mu,daemon_linkIndex_mu,daemon_mdDB_batchMu,daemon_mdDB_metalock,daemon_mdDB_mmaplock,daemon_mdDB_rwlock,daemon_mdDB_statlock,daemon_pluginManager_mu,daemon_pluginManager_muGC,daemon_statsCollector_m,container_LogCopier_copyJobs,container_StreamConfig_wg,container_attachContext_mu,child_children6660);
	child_children6660?0;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
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
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype children666(Mutexdef daemon_attachableNetworkLock_mu;Mutexdef daemon_containerdCli_connMu;Mutexdef daemon_EventsService_mu;Mutexdef daemon_linkIndex_mu;Mutexdef daemon_mdDB_batchMu;Mutexdef daemon_mdDB_metalock;Mutexdef daemon_mdDB_mmaplock;Mutexdef daemon_mdDB_rwlock;Mutexdef daemon_mdDB_statlock;Mutexdef daemon_pluginManager_mu;Mutexdef daemon_pluginManager_muGC;Mutexdef daemon_statsCollector_m;Wgdef c_LogCopier_copyJobs;Wgdef c_StreamConfig_wg;Mutexdef c_attachContext_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_children550 = [1] of {int};
	run children55(daemon_linkIndex_mu,c_LogCopier_copyJobs,c_StreamConfig_wg,c_attachContext_mu,child_children550);
	child_children550?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype children55(Mutexdef l_mu;Wgdef parent_LogCopier_copyJobs;Wgdef parent_StreamConfig_wg;Mutexdef parent_attachContext_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	l_mu.Lock!false;
	l_mu.Unlock!false;
	goto stop_process;
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

