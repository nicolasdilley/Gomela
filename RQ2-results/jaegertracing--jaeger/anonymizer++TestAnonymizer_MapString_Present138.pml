
// https://github.com/jaegertracing/jaeger/blob/master/cmd/anonymizer/app/anonymizer/anonymizer_test.go#L138
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAnonymizer_MapString_Present1380 = [1] of {int};
	run TestAnonymizer_MapString_Present138(child_TestAnonymizer_MapString_Present1380)
stop_process:skip
}

proctype TestAnonymizer_MapString_Present138(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_mapString1270 = [1] of {int};
	Mutexdef anonymizer_lock;
	run mutexMonitor(anonymizer_lock);
	run mapString127(anonymizer_lock,child_mapString1270);
	child_mapString1270?0;
	stop_process: skip;
	child!0
}
proctype mapString127(Mutexdef a_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	a_lock.Lock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
		a_lock.Unlock!false;
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

