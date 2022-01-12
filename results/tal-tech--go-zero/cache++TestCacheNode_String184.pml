// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/tal-tech/go-zero/blob//core/stores/cache/cachenode_test.go#L184
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCacheNode_String1840 = [1] of {int};
	run TestCacheNode_String184(child_TestCacheNode_String1840);
	run receiver(child_TestCacheNode_String1840)
stop_process:skip
}

proctype TestCacheNode_String184(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_String1160 = [1] of {int};
	Mutexdef cn_unstableExpiry_lock;
	Mutexdef cn_lock;
	run mutexMonitor(cn_lock);
	run mutexMonitor(cn_unstableExpiry_lock);
	run String116(cn_lock,cn_unstableExpiry_lock,child_String1160);
	child_String1160?0;
	stop_process: skip;
	child!0
}
proctype String116(Mutexdef c_lock;Mutexdef c_unstableExpiry_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
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

