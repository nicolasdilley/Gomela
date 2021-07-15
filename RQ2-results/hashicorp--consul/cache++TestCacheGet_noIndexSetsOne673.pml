
// https://github.com/hashicorp/consul/blob/master/agent/cache/cache_test.go#L673
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCacheGet_noIndexSetsOne6730 = [1] of {int};
	run TestCacheGet_noIndexSetsOne673(child_TestCacheGet_noIndexSetsOne6730)
stop_process:skip
}

proctype TestCacheGet_noIndexSetsOne673(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_RegisterType2690 = [1] of {int};
	Mutexdef c_entriesLock;
	Mutexdef c_typesLock;
	run mutexMonitor(c_typesLock);
	run mutexMonitor(c_entriesLock);
	run RegisterType269(c_typesLock,c_entriesLock,child_RegisterType2690);
	child_RegisterType2690?0;
	stop_process: skip;
	child!0
}
proctype RegisterType269(Mutexdef c_typesLock;Mutexdef c_entriesLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_typesLock.Lock!false;
	stop_process: skip;
		c_typesLock.Unlock!false;
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

