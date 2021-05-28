// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/consul/blob/8d6cbe72813779f60ac24d119cc311c21003f4ce/agent/cache/cache_test.go#L673
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCacheGet_noIndexSetsOne6730 = [1] of {int};
	run TestCacheGet_noIndexSetsOne673(child_TestCacheGet_noIndexSetsOne6730);
	run receiver(child_TestCacheGet_noIndexSetsOne6730)
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
	run RegisterType269(c_entriesLock,c_typesLock,child_RegisterType2690);
	child_RegisterType2690?0;
		stop_process: skip;
	stop_process: skip;
	child!0
}
proctype RegisterType269(Mutexdef c_entriesLock;Mutexdef c_typesLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_typesLock.Lock!false;
		defer1: skip;
	c_typesLock.Unlock!false;
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

