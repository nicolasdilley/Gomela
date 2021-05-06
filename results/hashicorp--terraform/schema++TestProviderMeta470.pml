
// https://github.com/hashicorp/terraform/blob/master/internal/legacy/helper/schema/provider_test.go#L470
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestProviderMeta4700 = [1] of {int};
	run TestProviderMeta470(child_TestProviderMeta4700)
stop_process:skip
}

proctype TestProviderMeta470(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Meta1412 = [1] of {int};
	chan child_SetMeta1481 = [1] of {int};
	chan child_Meta1410 = [1] of {int};
	Mutexdef p_stopOnce_m;
	Mutexdef p_stopMu;
	run mutexMonitor(p_stopMu);
	run mutexMonitor(p_stopOnce_m);
	run Meta141(p_stopMu,p_stopOnce_m,child_Meta1410);
	child_Meta1410?0;
	run SetMeta148(p_stopMu,p_stopOnce_m,child_SetMeta1481);
	child_SetMeta1481?0;
	run Meta141(p_stopMu,p_stopOnce_m,child_Meta1412);
	child_Meta1412?0;
	stop_process: skip;
	child!0
}
proctype Meta141(Mutexdef p_stopMu;Mutexdef p_stopOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype SetMeta148(Mutexdef p_stopMu;Mutexdef p_stopOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

