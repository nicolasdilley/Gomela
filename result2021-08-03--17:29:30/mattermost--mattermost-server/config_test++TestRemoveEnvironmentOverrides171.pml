// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/mattermost/mattermost-server/blob/5c16de58a02099df38e1e8486df148d1b798460a/config/common_test.go#L171
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRemoveEnvironmentOverrides1710 = [1] of {int};
	run TestRemoveEnvironmentOverrides171(child_TestRemoveEnvironmentOverrides1710);
	run receiver(child_TestRemoveEnvironmentOverrides1710)
stop_process:skip
}

proctype TestRemoveEnvironmentOverrides171(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_RemoveEnvironmentOverrides1551 = [1] of {int};
	chan child_Get1290 = [1] of {int};
	Mutexdef base_configLock;
	run mutexMonitor(base_configLock);
	run Get129(base_configLock,child_Get1290);
	child_Get1290?0;
	run RemoveEnvironmentOverrides155(base_configLock,child_RemoveEnvironmentOverrides1551);
	child_RemoveEnvironmentOverrides1551?0;
	stop_process: skip;
	child!0
}
proctype Get129(Mutexdef s_configLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_configLock.RLock!false;
	goto defer1;
		defer1: skip;
	s_configLock.RUnlock!false;
	stop_process: skip;
	child!0
}
proctype RemoveEnvironmentOverrides155(Mutexdef s_configLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetEnvironmentOverrides1431 = [1] of {int};
	s_configLock.RLock!false;
	run GetEnvironmentOverrides143(s_configLock,child_GetEnvironmentOverrides1431);
	child_GetEnvironmentOverrides1431?0;
	goto defer1;
		defer1: skip;
	s_configLock.RUnlock!false;
	stop_process: skip;
	child!0
}
proctype GetEnvironmentOverrides143(Mutexdef s_configLock;chan child) {
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

