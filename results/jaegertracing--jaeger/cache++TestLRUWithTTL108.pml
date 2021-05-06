
// https://github.com/jaegertracing/jaeger/blob/master/pkg/cache/lru_test.go#L108
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestLRUWithTTL1080 = [1] of {int};
	run TestLRUWithTTL108(child_TestLRUWithTTL1080)
stop_process:skip
}

proctype TestLRUWithTTL108(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Size1646 = [1] of {int};
	chan child_Get595 = [1] of {int};
	chan child_Get594 = [1] of {int};
	chan child_Get593 = [1] of {int};
	chan child_CompareAndSwap932 = [1] of {int};
	chan child_Get591 = [1] of {int};
	chan child_Put840 = [1] of {int};
	Mutexdef cache_mux;
	run mutexMonitor(cache_mux);
	run Put84(cache_mux,child_Put840);
	child_Put840?0;
	run Get59(cache_mux,child_Get591);
	child_Get591?0;
	run CompareAndSwap93(cache_mux,child_CompareAndSwap932);
	child_CompareAndSwap932?0;
	run Get59(cache_mux,child_Get593);
	child_Get593?0;
	run Get59(cache_mux,child_Get594);
	child_Get594?0;
	run Get59(cache_mux,child_Get595);
	child_Get595?0;
	run Size164(cache_mux,child_Size1646);
	child_Size1646?0;
	stop_process: skip;
	child!0
}
proctype Put84(Mutexdef c_mux;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_putWithMutexHold1160 = [1] of {int};
	c_mux.Lock!false;
	run putWithMutexHold116(c_mux,child_putWithMutexHold1160);
	child_putWithMutexHold1160?0;
	goto stop_process;
	stop_process: skip;
		c_mux.Unlock!false;
	child!0
}
proctype putWithMutexHold116(Mutexdef c_mux;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Get59(Mutexdef c_mux;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_mux.Lock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
		c_mux.Unlock!false;
	child!0
}
proctype CompareAndSwap93(Mutexdef c_mux;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_putWithMutexHold1162 = [1] of {int};
	c_mux.Lock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	run putWithMutexHold116(c_mux,child_putWithMutexHold1162);
	child_putWithMutexHold1162?0;
	goto stop_process;
	stop_process: skip;
		c_mux.Unlock!false;
	child!0
}
proctype Size164(Mutexdef c_mux;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_mux.Lock!false;
	goto stop_process;
	stop_process: skip;
		c_mux.Unlock!false;
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

