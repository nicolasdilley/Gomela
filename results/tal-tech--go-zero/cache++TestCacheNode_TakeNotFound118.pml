// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/tal-tech/go-zero/blob//core/stores/cache/cachenode_test.go#L118
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCacheNode_TakeNotFound1180 = [1] of {int};
	run TestCacheNode_TakeNotFound118(child_TestCacheNode_TakeNotFound1180);
	run receiver(child_TestCacheNode_TakeNotFound1180)
stop_process:skip
}

proctype TestCacheNode_TakeNotFound118(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Take1226 = [1] of {int};
	chan child_IsNotFound965 = [1] of {int};
	chan child_IsNotFound964 = [1] of {int};
	chan child_Take1223 = [1] of {int};
	chan child_IsNotFound962 = [1] of {int};
	chan child_IsNotFound961 = [1] of {int};
	chan child_Take1220 = [1] of {int};
	Mutexdef cn_unstableExpiry_lock;
	Mutexdef cn_lock;
	run mutexMonitor(cn_lock);
	run mutexMonitor(cn_unstableExpiry_lock);
	run Take122(cn_lock,cn_unstableExpiry_lock,child_Take1220);
	child_Take1220?0;
	run IsNotFound96(cn_lock,cn_unstableExpiry_lock,child_IsNotFound961);
	child_IsNotFound961?0;
	run IsNotFound96(cn_lock,cn_unstableExpiry_lock,child_IsNotFound962);
	child_IsNotFound962?0;
	run Take122(cn_lock,cn_unstableExpiry_lock,child_Take1223);
	child_Take1223?0;
	run IsNotFound96(cn_lock,cn_unstableExpiry_lock,child_IsNotFound964);
	child_IsNotFound964?0;
	run IsNotFound96(cn_lock,cn_unstableExpiry_lock,child_IsNotFound965);
	child_IsNotFound965?0;
	run Take122(cn_lock,cn_unstableExpiry_lock,child_Take1226);
	child_Take1226?0;
	stop_process: skip;
	child!0
}
proctype Take122(Mutexdef c_lock;Mutexdef c_unstableExpiry_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_doTake1720 = [1] of {int};
	run doTake172(c_lock,c_unstableExpiry_lock,child_doTake1720);
	child_doTake1720?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype doTake172(Mutexdef c_lock;Mutexdef c_unstableExpiry_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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
	child!0
}
proctype IsNotFound96(Mutexdef c_lock;Mutexdef c_unstableExpiry_lock;chan child) {
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

