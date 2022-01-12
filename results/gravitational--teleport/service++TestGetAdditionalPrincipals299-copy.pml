// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/gravitational/teleport/blob//lib/service/service_test.go#L299
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestGetAdditionalPrincipals2990 = [1] of {int};
	run TestGetAdditionalPrincipals299(child_TestGetAdditionalPrincipals2990);
	run receiver(child_TestGetAdditionalPrincipals2990)
stop_process:skip
}

proctype TestGetAdditionalPrincipals299(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef p_reporter_topRequestsCache_lock;
	Mutexdef p_keyMutex;
	Mutexdef p_localAuth_lock;
	int var_tests = -2; // opt var_tests
	run mutexMonitor(p_localAuth_lock);
	run mutexMonitor(p_keyMutex);
	run mutexMonitor(p_reporter_topRequestsCache_lock);
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

