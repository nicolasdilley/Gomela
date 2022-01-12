// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/tal-tech/go-zero/blob//core/stores/redis/redisblockingnode.go#L17
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_CreateBlockingNode170 = [1] of {int};
	run CreateBlockingNode17(child_CreateBlockingNode170);
	run receiver(child_CreateBlockingNode170)
stop_process:skip
}

proctype CreateBlockingNode17(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef client_cmdsInfoCache_once_m;
	Mutexdef client_nodes_mu;
	Mutexdef client_nodes_opt_TLSConfig_mutex;
	Mutexdef client_opt_TLSConfig_mutex;
	

	if
	:: true -> 
		goto stop_process
	:: true -> 
		run mutexMonitor(client_opt_TLSConfig_mutex);
		run mutexMonitor(client_nodes_opt_TLSConfig_mutex);
		run mutexMonitor(client_nodes_mu);
		run mutexMonitor(client_cmdsInfoCache_once_m);
		goto stop_process
	:: true -> 
		goto stop_process
	fi;
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

