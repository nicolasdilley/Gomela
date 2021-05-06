
// https://github.com/hashicorp/vault/blob/master/builtin/credential/approle/path_role_test.go#L1846
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAppRole_TokenutilUpgrade18460 = [1] of {int};
	run TestAppRole_TokenutilUpgrade1846(child_TestAppRole_TokenutilUpgrade18460)
stop_process:skip
}

proctype TestAppRole_TokenutilUpgrade1846(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef b_secretIDListingLock;
	Mutexdef b_saltMutex;
	Mutexdef s_once_m;
	run mutexMonitor(s_once_m);
	run mutexMonitor(b_saltMutex);
	run mutexMonitor(b_secretIDListingLock);
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

