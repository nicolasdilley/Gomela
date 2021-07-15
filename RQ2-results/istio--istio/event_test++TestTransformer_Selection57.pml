
// https://github.com/istio/istio/blob/master/pkg/config/event/transformer_test.go#L57
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestTransformer_Selection570 = [1] of {int};
	run TestTransformer_Selection57(child_TestTransformer_Selection570)
stop_process:skip
}

proctype TestTransformer_Selection57(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef accBaz_mu;
	Mutexdef accBoo_mu;
	run mutexMonitor(accBoo_mu);
	run mutexMonitor(accBaz_mu);
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

