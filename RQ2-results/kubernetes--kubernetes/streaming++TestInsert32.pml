
// https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/cri/streaming/request_cache_test.go#L32
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestInsert320 = [1] of {int};
	run TestInsert32(child_TestInsert320)
stop_process:skip
}

proctype TestInsert32(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Consume9412 = [1] of {int};
	chan child_assertCacheSize21011 = [1] of {int};
	chan child_Insert7310 = [1] of {int};
	chan child_assertCacheSize2109 = [1] of {int};
	chan child_Insert738 = [1] of {int};
	chan child_Consume947 = [1] of {int};
	chan child_assertCacheSize2106 = [1] of {int};
	chan child_Insert735 = [1] of {int};
	chan child_assertCacheSize2104 = [1] of {int};
	chan child_Insert733 = [1] of {int};
	chan child_Insert732 = [1] of {int};
	chan child_assertCacheSize2101 = [1] of {int};
	chan child_Insert730 = [1] of {int};
	Mutexdef c_lock;
	run mutexMonitor(c_lock);
	run Insert73(c_lock,child_Insert730);
	child_Insert730?0;
	run assertCacheSize210(c_lock,child_assertCacheSize2101);
	child_assertCacheSize2101?0;
	

	if
	:: 0 != -2 && maxInFlight - 2-1 != -3 -> 
				for(i : 0.. maxInFlight - 2-1) {
			for31: skip;
			run Insert73(c_lock,child_Insert733);
			child_Insert733?0;
			for31_end: skip
		};
		for31_exit: skip
	:: else -> 
		do
		:: true -> 
			for30: skip;
			run Insert73(c_lock,child_Insert732);
			child_Insert732?0;
			for30_end: skip
		:: true -> 
			break
		od;
		for30_exit: skip
	fi;
	run assertCacheSize210(c_lock,child_assertCacheSize2104);
	child_assertCacheSize2104?0;
	run Insert73(c_lock,child_Insert735);
	child_Insert735?0;
	run assertCacheSize210(c_lock,child_assertCacheSize2106);
	child_assertCacheSize2106?0;
	run Consume94(c_lock,child_Consume947);
	child_Consume947?0;
	run Insert73(c_lock,child_Insert738);
	child_Insert738?0;
	run assertCacheSize210(c_lock,child_assertCacheSize2109);
	child_assertCacheSize2109?0;
	run Insert73(c_lock,child_Insert7310);
	child_Insert7310?0;
	run assertCacheSize210(c_lock,child_assertCacheSize21011);
	child_assertCacheSize21011?0;
	run Consume94(c_lock,child_Consume9412);
	child_Consume9412?0;
	stop_process: skip;
	child!0
}
proctype Insert73(Mutexdef c_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_uniqueToken1131 = [1] of {int};
	chan child_gc1330 = [1] of {int};
	c_lock.Lock!false;
	run gc133(c_lock,child_gc1330);
	child_gc1330?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run uniqueToken113(c_lock,child_uniqueToken1131);
	child_uniqueToken1131?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
		c_lock.Unlock!false;
	child!0
}
proctype gc133(Mutexdef c_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype uniqueToken113(Mutexdef c_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype assertCacheSize210(Mutexdef cache_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype Consume94(Mutexdef c_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_lock.Lock!false;
	

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
		c_lock.Unlock!false;
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

