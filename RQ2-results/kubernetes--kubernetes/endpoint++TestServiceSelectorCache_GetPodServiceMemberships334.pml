
// https://github.com/kubernetes/kubernetes/blob/master/pkg/controller/util/endpoint/controller_utils_test.go#L334
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestServiceSelectorCache_GetPodServiceMemberships3340 = [1] of {int};
	run TestServiceSelectorCache_GetPodServiceMemberships334(child_TestServiceSelectorCache_GetPodServiceMemberships3340)
stop_process:skip
}

proctype TestServiceSelectorCache_GetPodServiceMemberships334(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef cache_lock;
	run mutexMonitor(cache_lock);
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

