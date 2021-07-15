
// https://github.com/istio/istio/blob/master/galley/pkg/config/processing/snapshotter/strategy/debounce_test.go#L165
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestStrategy_NewWithDefaults1650 = [1] of {int};
	run TestStrategy_NewWithDefaults165(child_TestStrategy_NewWithDefaults1650)
stop_process:skip
}

proctype TestStrategy_NewWithDefaults165(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef s_mu;
	run mutexMonitor(s_mu);
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

