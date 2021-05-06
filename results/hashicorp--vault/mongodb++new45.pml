
// https://github.com/hashicorp/vault/blob/master/plugins/database/mongodb/mongodb.go#L45
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_new450 = [1] of {int};
	run new45(child_new450)
stop_process:skip
}

proctype new45(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef connProducer_client_keyVaultColl_registry_mu;
	Mutexdef connProducer_client_keyVaultColl_db_registry_mu;
	Mutexdef connProducer_client_sessionPool_mutex;
	Mutexdef connProducer_client_registry_mu;
	Mutexdef connProducer_client_clock_lock;
	Mutexdef connProducer_clientOptions_TLSConfig_mutex;
	Mutexdef connProducer_clientOptions_Registry_mu;
	run mutexMonitor(connProducer_clientOptions_Registry_mu);
	run mutexMonitor(connProducer_clientOptions_TLSConfig_mutex);
	run mutexMonitor(connProducer_client_clock_lock);
	run mutexMonitor(connProducer_client_registry_mu);
	run mutexMonitor(connProducer_client_sessionPool_mutex);
	run mutexMonitor(connProducer_client_keyVaultColl_db_registry_mu);
	run mutexMonitor(connProducer_client_keyVaultColl_registry_mu);
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

