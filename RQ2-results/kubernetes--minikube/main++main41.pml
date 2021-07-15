
// https://github.com//blob/master//Users/xxx/Library/Caches/go-build/ad/ada14ea4d4d064b3534ec1813c1bc3b4ff00d461c877d32575193fd80853fd53-d#L41
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_main410 = [1] of {int};
	run main41(child_main410)
stop_process:skip
}

proctype main41(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_TestMain300 = [1] of {int};
	Mutexdef m_afterOnce_m;
	run mutexMonitor(m_afterOnce_m);
	run TestMain30(m_afterOnce_m,child_TestMain300);
	child_TestMain300?0;
	stop_process: skip;
	child!0
}
proctype TestMain30(Mutexdef m_afterOnce_m;chan child) {
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

