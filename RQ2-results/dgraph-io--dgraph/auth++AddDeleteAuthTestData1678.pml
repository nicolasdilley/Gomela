
// https://github.com/dgraph-io/dgraph/blob/master/graphql/e2e/auth/auth_test.go#L1678
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_AddDeleteAuthTestData16780 = [1] of {int};
	run AddDeleteAuthTestData1678(child_AddDeleteAuthTestData16780)
stop_process:skip
}

proctype AddDeleteAuthTestData1678(chan child) {
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

