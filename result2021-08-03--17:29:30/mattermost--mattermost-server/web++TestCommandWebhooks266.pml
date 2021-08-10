// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/mattermost/mattermost-server/blob/5c16de58a02099df38e1e8486df148d1b798460a/web/webhook_test.go#L266
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCommandWebhooks2660 = [1] of {int};
	run TestCommandWebhooks266(child_TestCommandWebhooks2660);
	run receiver(child_TestCommandWebhooks2660)
stop_process:skip
}

proctype TestCommandWebhooks266(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_TearDown1610 = [1] of {int};
	Mutexdef th_Server_featureFlagSynchronizerMutex;
	Mutexdef th_Server_uploadLockMapMut;
	Mutexdef th_Server_pluginCommandsLock;
	Mutexdef th_Server_PluginsLock;
	Mutexdef th_Server_metricsLock;
	run mutexMonitor(th_Server_metricsLock);
	run mutexMonitor(th_Server_PluginsLock);
	run mutexMonitor(th_Server_pluginCommandsLock);
	run mutexMonitor(th_Server_uploadLockMapMut);
	run mutexMonitor(th_Server_featureFlagSynchronizerMutex);
		defer1: skip;
	run TearDown161(th_Server_featureFlagSynchronizerMutex,th_Server_metricsLock,th_Server_PluginsLock,th_Server_pluginCommandsLock,th_Server_uploadLockMapMut,child_TearDown1610);
	child_TearDown1610?0;
	stop_process: skip;
	child!0
}
proctype TearDown161(Mutexdef th_Server_featureFlagSynchronizerMutex;Mutexdef th_Server_metricsLock;Mutexdef th_Server_PluginsLock;Mutexdef th_Server_pluginCommandsLock;Mutexdef th_Server_uploadLockMapMut;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

