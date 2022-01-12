// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/containers/podman/blob//pkg/hooks/hooks_test.go#L144
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestInvalidStage1440 = [1] of {int};
	run TestInvalidStage144(child_TestInvalidStage1440);
	run receiver(child_TestInvalidStage1440)
stop_process:skip
}

proctype TestInvalidStage144(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Hooks980 = [1] of {int};
	Mutexdef manager_lock;
	run mutexMonitor(manager_lock);
	run Hooks98(manager_lock,child_Hooks980);
	child_Hooks980?0;
	stop_process: skip;
	child!0
}
proctype Hooks98(Mutexdef m_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_namedHooks690 = [1] of {int};
	int var_namedHook_hook_Stages = -2; // opt var_namedHook_hook_Stages
	int var_hooks = -2; // opt var_hooks
	int var_m_extensionStages = -2; // opt var_m_extensionStages
	run namedHooks69(m_lock,child_namedHooks690);
	child_namedHooks690?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype namedHooks69(Mutexdef m_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_m_hooks = -2; // opt var_m_hooks
	m_lock.Lock!false;
	goto defer1;
		defer1: skip;
	m_lock.Unlock!false;
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

