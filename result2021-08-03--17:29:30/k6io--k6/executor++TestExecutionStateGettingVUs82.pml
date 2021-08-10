// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/k6io/k6/blob/af1e032ebf949cde092d4a2eddb78528ea0a5864/lib/executor/execution_test.go#L82
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestExecutionStateGettingVUs820 = [1] of {int};
	run TestExecutionStateGettingVUs82(child_TestExecutionStateGettingVUs820);
	run receiver(child_TestExecutionStateGettingVUs820)
stop_process:skip
}

proctype TestExecutionStateGettingVUs82(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Drain515 = [1] of {int};
	chan child_Drain514 = [1] of {int};
	chan child_Drain513 = [1] of {int};
	chan child_Drain512 = [1] of {int};
	chan child_Drain511 = [1] of {int};
	chan child_Drain510 = [1] of {int};
	Mutexdef es_pauseStateLock;
	Mutexdef testLog_mu_lock;
	Mutexdef logHook_mutex;
	int var_entries = -2; // opt var_entries
	run mutexMonitor(logHook_mutex);
	run mutexMonitor(testLog_mu_lock);
	run mutexMonitor(es_pauseStateLock);
	

	if
	:: 0 != -2 && 10-1 != -3 -> 
				for(i : 0.. 10-1) {
			for21: skip;
			run Drain51(logHook_mutex,child_Drain511);
			child_Drain511?0;
			for21_end: skip
		};
		for21_exit: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			run Drain51(logHook_mutex,child_Drain510);
			child_Drain510?0;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	run Drain51(logHook_mutex,child_Drain512);
	child_Drain512?0;
	

	if
	:: 0 != -2 && 10-1 != -3 -> 
				for(i : 0.. 10-1) {
			for41: skip;
			run Drain51(logHook_mutex,child_Drain514);
			child_Drain514?0;
			for41_end: skip
		};
		for41_exit: skip
	:: else -> 
		do
		:: true -> 
			for40: skip;
			run Drain51(logHook_mutex,child_Drain513);
			child_Drain513?0;
			for40_end: skip
		:: true -> 
			break
		od;
		for40_exit: skip
	fi;
	run Drain51(logHook_mutex,child_Drain515);
	child_Drain515?0;
	stop_process: skip;
	child!0
}
proctype Drain51(Mutexdef smh_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	smh_mutex.Lock!false;
	goto defer1;
		defer1: skip;
	smh_mutex.Unlock!false;
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

