// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/mattermost/mattermost-server/blob/5c16de58a02099df38e1e8486df148d1b798460a/cmd/mattermost/commands/group.go#L283
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_teamGroupStatusCmdF2830 = [1] of {int};
	run teamGroupStatusCmdF283(child_teamGroupStatusCmdF2830);
	run receiver(child_teamGroupStatusCmdF2830)
stop_process:skip
}

proctype teamGroupStatusCmdF283(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getTeamFromTeamArg200 = [1] of {int};
	Mutexdef a_srv_featureFlagSynchronizerMutex;
	Mutexdef a_srv_uploadLockMapMut;
	Mutexdef a_srv_pluginCommandsLock;
	Mutexdef a_srv_PluginsLock;
	Mutexdef a_srv_metricsLock;
	run mutexMonitor(a_srv_metricsLock);
	run mutexMonitor(a_srv_PluginsLock);
	run mutexMonitor(a_srv_pluginCommandsLock);
	run mutexMonitor(a_srv_uploadLockMapMut);
	run mutexMonitor(a_srv_featureFlagSynchronizerMutex);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run getTeamFromTeamArg20(a_srv_featureFlagSynchronizerMutex,a_srv_metricsLock,a_srv_PluginsLock,a_srv_pluginCommandsLock,a_srv_uploadLockMapMut,child_getTeamFromTeamArg200);
	child_getTeamFromTeamArg200?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
		stop_process: skip;
	stop_process: skip;
	child!0
}
proctype getTeamFromTeamArg20(Mutexdef a_srv_featureFlagSynchronizerMutex;Mutexdef a_srv_metricsLock;Mutexdef a_srv_PluginsLock;Mutexdef a_srv_pluginCommandsLock;Mutexdef a_srv_uploadLockMapMut;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

