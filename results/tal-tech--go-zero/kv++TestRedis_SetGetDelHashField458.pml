// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/tal-tech/go-zero/blob//core/stores/kv/store_test.go#L458
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRedis_SetGetDelHashField4580 = [1] of {int};
	run TestRedis_SetGetDelHashField458(child_TestRedis_SetGetDelHashField4580);
	run receiver(child_TestRedis_SetGetDelHashField4580)
stop_process:skip
}

proctype TestRedis_SetGetDelHashField458(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Hdel1713 = [1] of {int};
	chan child_Hexists1802 = [1] of {int};
	chan child_Hget1891 = [1] of {int};
	chan child_Hset2430 = [1] of {int};
	Mutexdef store_dispatcher_lock;
	run mutexMonitor(store_dispatcher_lock);
	run Hset243(store_dispatcher_lock,child_Hset2430);
	child_Hset2430?0;
	run Hget189(store_dispatcher_lock,child_Hget1891);
	child_Hget1891?0;
	run Hexists180(store_dispatcher_lock,child_Hexists1802);
	child_Hexists1802?0;
	run Hdel171(store_dispatcher_lock,child_Hdel1713);
	child_Hdel1713?0;
	stop_process: skip;
	child!0
}
proctype Hset243(Mutexdef cs_dispatcher_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getRedis6600 = [1] of {int};
	run getRedis660(cs_dispatcher_lock,child_getRedis6600);
	child_getRedis6600?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getRedis660(Mutexdef cs_dispatcher_lock;chan child) {
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
proctype Hget189(Mutexdef cs_dispatcher_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getRedis6601 = [1] of {int};
	run getRedis660(cs_dispatcher_lock,child_getRedis6601);
	child_getRedis6601?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Hexists180(Mutexdef cs_dispatcher_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getRedis6602 = [1] of {int};
	run getRedis660(cs_dispatcher_lock,child_getRedis6602);
	child_getRedis6602?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Hdel171(Mutexdef cs_dispatcher_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getRedis6603 = [1] of {int};
	run getRedis660(cs_dispatcher_lock,child_getRedis6603);
	child_getRedis6603?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

