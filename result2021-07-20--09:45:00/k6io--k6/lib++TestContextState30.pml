// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/k6io/k6/blob/af1e032ebf949cde092d4a2eddb78528ea0a5864/lib/context_test.go#L30
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestContextState300 = [1] of {int};
	run TestContextState30(child_TestContextState300);
	run receiver(child_TestContextState300)
stop_process:skip
}

proctype TestContextState30(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_WithState310 = [1] of {int};
	Mutexdef st_RPSLimit_mu;
	Mutexdef st_TLSConfig_mutex;
	Mutexdef st_CookieJar_mu;
	Mutexdef st_Group_checkMutex;
	Mutexdef st_Group_groupMutex;
	run mutexMonitor(st_Group_groupMutex);
	run mutexMonitor(st_Group_checkMutex);
	run mutexMonitor(st_CookieJar_mu);
	run mutexMonitor(st_TLSConfig_mutex);
	run mutexMonitor(st_RPSLimit_mu);
	run WithState31(st_CookieJar_mu,st_Group_checkMutex,st_Group_groupMutex,st_RPSLimit_mu,st_TLSConfig_mutex,child_WithState310);
	child_WithState310?0;
	stop_process: skip;
	child!0
}
proctype WithState31(Mutexdef state_CookieJar_mu;Mutexdef state_Group_checkMutex;Mutexdef state_Group_groupMutex;Mutexdef state_RPSLimit_mu;Mutexdef state_TLSConfig_mutex;chan child) {
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

