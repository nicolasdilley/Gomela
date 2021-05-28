// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/mattermost/mattermost-server/blob/5c16de58a02099df38e1e8486df148d1b798460a/cmd/mattermost/commands/cmdtestlib.go#L40
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_Setup400 = [1] of {int};
	run Setup40(child_Setup400);
	run receiver(child_Setup400)
stop_process:skip
}

proctype Setup40(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef api4TestHelper_BasicPost_propsMu;
	Mutexdef api4TestHelper_ConfigStore_configLock;
	Mutexdef api4TestHelper_Server_featureFlagSynchronizerMutex;
	Mutexdef api4TestHelper_Server_uploadLockMapMut;
	Mutexdef api4TestHelper_Server_pluginCommandsLock;
	Mutexdef api4TestHelper_Server_PluginsLock;
	Mutexdef api4TestHelper_Server_metricsLock;
	run mutexMonitor(api4TestHelper_Server_metricsLock);
	run mutexMonitor(api4TestHelper_Server_PluginsLock);
	run mutexMonitor(api4TestHelper_Server_pluginCommandsLock);
	run mutexMonitor(api4TestHelper_Server_uploadLockMapMut);
	run mutexMonitor(api4TestHelper_Server_featureFlagSynchronizerMutex);
	run mutexMonitor(api4TestHelper_ConfigStore_configLock);
	run mutexMonitor(api4TestHelper_BasicPost_propsMu);
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

