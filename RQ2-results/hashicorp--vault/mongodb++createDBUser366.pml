
// https://github.com/hashicorp/vault/blob/master/plugins/database/mongodb/mongodb_test.go#L366
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_createDBUser3660 = [1] of {int};
	run createDBUser366(child_createDBUser3660)
stop_process:skip
}

proctype createDBUser366(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef result_reg_mu;
	Mutexdef result_cur_clientSession_pool_mutex;
	Mutexdef result_cur_registry_mu;
	Mutexdef client_keyVaultColl_registry_mu;
	Mutexdef client_keyVaultColl_db_registry_mu;
	Mutexdef client_sessionPool_mutex;
	Mutexdef client_registry_mu;
	Mutexdef client_clock_lock;
	run mutexMonitor(client_clock_lock);
	run mutexMonitor(client_registry_mu);
	run mutexMonitor(client_sessionPool_mutex);
	run mutexMonitor(client_keyVaultColl_db_registry_mu);
	run mutexMonitor(client_keyVaultColl_registry_mu);
	run mutexMonitor(result_cur_registry_mu);
	run mutexMonitor(result_cur_clientSession_pool_mutex);
	run mutexMonitor(result_reg_mu);
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

