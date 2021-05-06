
// https://github.com/ethereum/go-ethereum/blob/master/metrics/sample_test.go#L173
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestExpDecaySampleRescale1730 = [1] of {int};
	run TestExpDecaySampleRescale173(child_TestExpDecaySampleRescale1730)
stop_process:skip
}

proctype TestExpDecaySampleRescale173(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_update1641 = [1] of {int};
	chan child_update1640 = [1] of {int};
	Mutexdef s_mutex;
	run mutexMonitor(s_mutex);
	run update164(s_mutex,child_update1640);
	child_update1640?0;
	run update164(s_mutex,child_update1641);
	child_update1641?0;
	stop_process: skip;
	child!0
}
proctype update164(Mutexdef s_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_mutex.Lock!false;
	stop_process: skip;
		s_mutex.Unlock!false;
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

