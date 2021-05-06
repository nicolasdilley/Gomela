
// https://github.com/jaegertracing/jaeger/blob/master/pkg/cache/lru_test.go#L26
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestLRU260 = [1] of {int};
	run TestLRU26(child_TestLRU260)
stop_process:skip
}

proctype TestLRU26(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Get5921 = [1] of {int};
	chan child_Delete14920 = [1] of {int};
	chan child_Get5919 = [1] of {int};
	chan child_Put8418 = [1] of {int};
	chan child_Get5917 = [1] of {int};
	chan child_Get5916 = [1] of {int};
	chan child_Get5915 = [1] of {int};
	chan child_Get5914 = [1] of {int};
	chan child_Put8413 = [1] of {int};
	chan child_Get5912 = [1] of {int};
	chan child_Put8411 = [1] of {int};
	chan child_Get5910 = [1] of {int};
	chan child_Get599 = [1] of {int};
	chan child_Get598 = [1] of {int};
	chan child_Size1647 = [1] of {int};
	chan child_Put846 = [1] of {int};
	chan child_Put845 = [1] of {int};
	chan child_Put844 = [1] of {int};
	chan child_Size1643 = [1] of {int};
	chan child_Get592 = [1] of {int};
	chan child_Get591 = [1] of {int};
	chan child_Put840 = [1] of {int};
	Mutexdef cache_mux;
	run mutexMonitor(cache_mux);
	run Put84(cache_mux,child_Put840);
	child_Put840?0;
	run Get59(cache_mux,child_Get591);
	child_Get591?0;
	run Get59(cache_mux,child_Get592);
	child_Get592?0;
	run Size164(cache_mux,child_Size1643);
	child_Size1643?0;
	run Put84(cache_mux,child_Put844);
	child_Put844?0;
	run Put84(cache_mux,child_Put845);
	child_Put845?0;
	run Put84(cache_mux,child_Put846);
	child_Put846?0;
	run Size164(cache_mux,child_Size1647);
	child_Size1647?0;
	run Get59(cache_mux,child_Get598);
	child_Get598?0;
	run Get59(cache_mux,child_Get599);
	child_Get599?0;
	run Get59(cache_mux,child_Get5910);
	child_Get5910?0;
	run Put84(cache_mux,child_Put8411);
	child_Put8411?0;
	run Get59(cache_mux,child_Get5912);
	child_Get5912?0;
	run Put84(cache_mux,child_Put8413);
	child_Put8413?0;
	run Get59(cache_mux,child_Get5914);
	child_Get5914?0;
	run Get59(cache_mux,child_Get5915);
	child_Get5915?0;
	run Get59(cache_mux,child_Get5916);
	child_Get5916?0;
	run Get59(cache_mux,child_Get5917);
	child_Get5917?0;
	run Put84(cache_mux,child_Put8418);
	child_Put8418?0;
	run Get59(cache_mux,child_Get5919);
	child_Get5919?0;
	run Delete149(cache_mux,child_Delete14920);
	child_Delete14920?0;
	run Get59(cache_mux,child_Get5921);
	child_Get5921?0;
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
proctype Delete149(Mutexdef c_mux;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_mux.Lock!false;
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

