
// https://github.com/goharbor/harbor/blob/master/src/common/security/local/context_test.go#L76
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestGetUsername760 = [1] of {int};
	run TestGetUsername76(child_TestGetUsername760)
stop_process:skip
}

proctype TestGetUsername76(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetUsername601 = [1] of {int};
	chan child_GetUsername600 = [1] of {int};
	Mutexdef ctx_once_m;
	run mutexMonitor(ctx_once_m);
	run GetUsername60(ctx_once_m,child_GetUsername600);
	child_GetUsername600?0;
	run GetUsername60(ctx_once_m,child_GetUsername601);
	child_GetUsername601?0;
	stop_process: skip;
	child!0
}
proctype GetUsername60(Mutexdef s_once_m;chan child) {
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

