
// https://github.com/hashicorp/terraform/blob/master/internal/legacy/helper/schema/provider_test.go#L21
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestProviderGetSchema210 = [1] of {int};
	run TestProviderGetSchema21(child_TestProviderGetSchema210)
stop_process:skip
}

proctype TestProviderGetSchema21(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetSchema2040 = [1] of {int};
	Mutexdef p_stopOnce_m;
	Mutexdef p_stopMu;
	run mutexMonitor(p_stopMu);
	run mutexMonitor(p_stopOnce_m);
	run GetSchema204(p_stopMu,p_stopOnce_m,child_GetSchema2040);
	child_GetSchema2040?0;
	stop_process: skip;
	child!0
}
proctype GetSchema204(Mutexdef p_stopMu;Mutexdef p_stopOnce_m;chan child) {
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

