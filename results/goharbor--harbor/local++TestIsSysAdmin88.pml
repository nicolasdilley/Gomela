
// https://github.com/goharbor/harbor/blob/master/src/common/security/local/context_test.go#L88
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestIsSysAdmin880 = [1] of {int};
	run TestIsSysAdmin88(child_TestIsSysAdmin880)
stop_process:skip
}

proctype TestIsSysAdmin88(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_IsSysAdmin742 = [1] of {int};
	chan child_IsSysAdmin741 = [1] of {int};
	chan child_IsSysAdmin740 = [1] of {int};
	Mutexdef ctx_once_m;
	run mutexMonitor(ctx_once_m);
	run IsSysAdmin74(ctx_once_m,child_IsSysAdmin740);
	child_IsSysAdmin740?0;
	run IsSysAdmin74(ctx_once_m,child_IsSysAdmin741);
	child_IsSysAdmin741?0;
	run IsSysAdmin74(ctx_once_m,child_IsSysAdmin742);
	child_IsSysAdmin742?0;
	stop_process: skip;
	child!0
}
proctype IsSysAdmin74(Mutexdef s_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_IsAuthenticated540 = [1] of {int};
	run IsAuthenticated54(s_once_m,child_IsAuthenticated540);
	child_IsAuthenticated540?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype IsAuthenticated54(Mutexdef s_once_m;chan child) {
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

