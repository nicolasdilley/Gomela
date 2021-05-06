
// https://github.com/goharbor/harbor/blob/master/src/common/security/local/context_test.go#L259
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestSysadminPerms2590 = [1] of {int};
	run TestSysadminPerms259(child_TestSysadminPerms2590)
stop_process:skip
}

proctype TestSysadminPerms259(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Can872 = [1] of {int};
	chan child_Can871 = [1] of {int};
	chan child_Can870 = [1] of {int};
	Mutexdef ctx_once_m;
	run mutexMonitor(ctx_once_m);
	run Can87(ctx_once_m,child_Can870);
	child_Can870?0;
	run Can87(ctx_once_m,child_Can871);
	child_Can871?0;
	run Can87(ctx_once_m,child_Can872);
	child_Can872?0;
	stop_process: skip;
	child!0
}
proctype Can87(Mutexdef s_once_m;chan child) {
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

