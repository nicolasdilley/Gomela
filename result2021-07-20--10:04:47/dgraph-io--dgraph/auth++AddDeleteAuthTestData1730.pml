// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/dgraph-io/dgraph/blob/6b188f254202f9c38b16c4769b672dd0e9d596ac/graphql/e2e/auth/auth_test.go#L1730
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_AddDeleteAuthTestData17300 = [1] of {int};
	run AddDeleteAuthTestData1730(child_AddDeleteAuthTestData17300);
	run receiver(child_AddDeleteAuthTestData17300)
stop_process:skip
}

proctype AddDeleteAuthTestData1730(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef client_jwtMutex;
	run mutexMonitor(client_jwtMutex);
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
