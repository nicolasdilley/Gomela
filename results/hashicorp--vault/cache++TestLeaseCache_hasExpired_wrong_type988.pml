
// https://github.com/hashicorp/vault/blob/master/command/agent/cache/lease_cache_test.go#L988
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestLeaseCache_hasExpired_wrong_type9880 = [1] of {int};
	run TestLeaseCache_hasExpired_wrong_type988(child_TestLeaseCache_hasExpired_wrong_type9880)
stop_process:skip
}

proctype TestLeaseCache_hasExpired_wrong_type988(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_hasExpired12740 = [1] of {int};
	Mutexdef lc_ps_db_statlock;
	Mutexdef lc_ps_db_mmaplock;
	Mutexdef lc_ps_db_metalock;
	Mutexdef lc_ps_db_rwlock;
	Mutexdef lc_ps_db_batch_start_m;
	Mutexdef lc_ps_db_batchMu;
	Mutexdef lc_ps_db_freelistLoad_m;
	Mutexdef lc_l;
	Mutexdef lc_client_config_Limiter_mu;
	Mutexdef lc_client_config_modifyLock;
	Mutexdef lc_client_modifyLock;
	run mutexMonitor(lc_client_modifyLock);
	run mutexMonitor(lc_client_config_modifyLock);
	run mutexMonitor(lc_client_config_Limiter_mu);
	run mutexMonitor(lc_l);
	run mutexMonitor(lc_ps_db_freelistLoad_m);
	run mutexMonitor(lc_ps_db_batchMu);
	run mutexMonitor(lc_ps_db_batch_start_m);
	run mutexMonitor(lc_ps_db_rwlock);
	run mutexMonitor(lc_ps_db_metalock);
	run mutexMonitor(lc_ps_db_mmaplock);
	run mutexMonitor(lc_ps_db_statlock);
	run hasExpired1274(lc_client_modifyLock,lc_client_config_modifyLock,lc_client_config_Limiter_mu,lc_l,lc_ps_db_freelistLoad_m,lc_ps_db_batchMu,lc_ps_db_batch_start_m,lc_ps_db_rwlock,lc_ps_db_metalock,lc_ps_db_mmaplock,lc_ps_db_statlock,child_hasExpired12740);
	child_hasExpired12740?0;
	stop_process: skip;
	child!0
}
proctype hasExpired1274(Mutexdef c_client_modifyLock;Mutexdef c_client_config_modifyLock;Mutexdef c_client_config_Limiter_mu;Mutexdef c_l;Mutexdef c_ps_db_freelistLoad_m;Mutexdef c_ps_db_batchMu;Mutexdef c_ps_db_batch_start_m;Mutexdef c_ps_db_rwlock;Mutexdef c_ps_db_metalock;Mutexdef c_ps_db_mmaplock;Mutexdef c_ps_db_statlock;chan child) {
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
	

	if
	:: true;
	:: true;
	:: true -> 
		goto stop_process
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

