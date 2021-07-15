
// https://github.com//blob/master//Users/xxx/Library/Caches/go-build/f0/f014b57f4637b86998185893fb8fba154399a2864f14a9ac110c5719a503442d-d#L91
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_main910 = [1] of {int};
	run main91(child_main910)
stop_process:skip
}

proctype main91(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_TestMain150 = [1] of {int};
	Mutexdef m_afterOnce_m;
	run mutexMonitor(m_afterOnce_m);
	run TestMain15(m_afterOnce_m,child_TestMain150);
	child_TestMain150?0;
	stop_process: skip;
	child!0
}
proctype TestMain15(Mutexdef m_afterOnce_m;chan child) {
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

