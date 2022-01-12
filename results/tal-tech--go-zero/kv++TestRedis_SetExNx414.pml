// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/tal-tech/go-zero/blob//core/stores/kv/store_test.go#L414
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRedis_SetExNx4140 = [1] of {int};
	run TestRedis_SetExNx414(child_TestRedis_SetExNx4140);
	run receiver(child_TestRedis_SetExNx4140)
stop_process:skip
}

proctype TestRedis_SetExNx414(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SetnxEx4233 = [1] of {int};
	chan child_Ttl4872 = [1] of {int};
	chan child_Setnx4141 = [1] of {int};
	chan child_Setex4050 = [1] of {int};
	Mutexdef store_dispatcher_lock;
	run mutexMonitor(store_dispatcher_lock);
	run Setex405(store_dispatcher_lock,child_Setex4050);
	child_Setex4050?0;
	run Setnx414(store_dispatcher_lock,child_Setnx4141);
	child_Setnx4141?0;
	run Ttl487(store_dispatcher_lock,child_Ttl4872);
	child_Ttl4872?0;
	run SetnxEx423(store_dispatcher_lock,child_SetnxEx4233);
	child_SetnxEx4233?0;
	stop_process: skip;
	child!0
}
proctype Setex405(Mutexdef cs_dispatcher_lock;chan child) {
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
proctype Setnx414(Mutexdef cs_dispatcher_lock;chan child) {
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
proctype Ttl487(Mutexdef cs_dispatcher_lock;chan child) {
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
proctype SetnxEx423(Mutexdef cs_dispatcher_lock;chan child) {
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

