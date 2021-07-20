// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/jaegertracing/jaeger/blob/12bba8c9b91cf4a29d314934bc08f4a80e43c042/pkg/cache/lru_test.go#L64
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCompareAndSwap640 = [1] of {int};
	run TestCompareAndSwap64(child_TestCompareAndSwap640);
	run receiver(child_TestCompareAndSwap640)
stop_process:skip
}

proctype TestCompareAndSwap64(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Get5917 = [1] of {int};
	chan child_Get5916 = [1] of {int};
	chan child_CompareAndSwap9315 = [1] of {int};
	chan child_Get5914 = [1] of {int};
	chan child_CompareAndSwap9313 = [1] of {int};
	chan child_Get5912 = [1] of {int};
	chan child_CompareAndSwap9311 = [1] of {int};
	chan child_Get5910 = [1] of {int};
	chan child_CompareAndSwap939 = [1] of {int};
	chan child_Get598 = [1] of {int};
	chan child_CompareAndSwap937 = [1] of {int};
	chan child_Get596 = [1] of {int};
	chan child_Size1645 = [1] of {int};
	chan child_CompareAndSwap934 = [1] of {int};
	chan child_Size1643 = [1] of {int};
	chan child_Get592 = [1] of {int};
	chan child_Get591 = [1] of {int};
	chan child_CompareAndSwap930 = [1] of {int};
	Mutexdef cache_mux;
	run mutexMonitor(cache_mux);
	run CompareAndSwap93(cache_mux,child_CompareAndSwap930);
	child_CompareAndSwap930?0;
	run Get59(cache_mux,child_Get591);
	child_Get591?0;
	run Get59(cache_mux,child_Get592);
	child_Get592?0;
	run Size164(cache_mux,child_Size1643);
	child_Size1643?0;
	run CompareAndSwap93(cache_mux,child_CompareAndSwap934);
	child_CompareAndSwap934?0;
	run Size164(cache_mux,child_Size1645);
	child_Size1645?0;
	run Get59(cache_mux,child_Get596);
	child_Get596?0;
	run CompareAndSwap93(cache_mux,child_CompareAndSwap937);
	child_CompareAndSwap937?0;
	run Get59(cache_mux,child_Get598);
	child_Get598?0;
	run CompareAndSwap93(cache_mux,child_CompareAndSwap939);
	child_CompareAndSwap939?0;
	run Get59(cache_mux,child_Get5910);
	child_Get5910?0;
	run CompareAndSwap93(cache_mux,child_CompareAndSwap9311);
	child_CompareAndSwap9311?0;
	run Get59(cache_mux,child_Get5912);
	child_Get5912?0;
	run CompareAndSwap93(cache_mux,child_CompareAndSwap9313);
	child_CompareAndSwap9313?0;
	run Get59(cache_mux,child_Get5914);
	child_Get5914?0;
	run CompareAndSwap93(cache_mux,child_CompareAndSwap9315);
	child_CompareAndSwap9315?0;
	run Get59(cache_mux,child_Get5916);
	child_Get5916?0;
	run Get59(cache_mux,child_Get5917);
	child_Get5917?0;
	stop_process: skip;
	child!0
}
proctype CompareAndSwap93(Mutexdef c_mux;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_putWithMutexHold1160 = [1] of {int};
	c_mux.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto defer1
		:: true;
		fi
	:: true;
	fi;
	run putWithMutexHold116(c_mux,child_putWithMutexHold1160);
	child_putWithMutexHold1160?0;
	goto defer1;
		defer1: skip;
	c_mux.Unlock!false;
	stop_process: skip;
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
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	c_mux.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Size164(Mutexdef c_mux;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_mux.Lock!false;
	goto defer1;
		defer1: skip;
	c_mux.Unlock!false;
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

proctype receiver(chan c) {
c?0
}

