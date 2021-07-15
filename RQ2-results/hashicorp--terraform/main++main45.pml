
// https://github.com//blob/master//Users/xxx/Library/Caches/go-build/75/752b1359b031a461fe33d23e40606f0c6a8e6624b16f5966713b7067a0baa84d-d#L45
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_main450 = [1] of {int};
	run main45(child_main450)
stop_process:skip
}

proctype main45(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_TestMain120 = [1] of {int};
	Mutexdef m_afterOnce_m;
	run mutexMonitor(m_afterOnce_m);
	run TestMain12(m_afterOnce_m,child_TestMain120);
	child_TestMain120?0;
	stop_process: skip;
	child!0
}
proctype TestMain12(Mutexdef m_afterOnce_m;chan child) {
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

