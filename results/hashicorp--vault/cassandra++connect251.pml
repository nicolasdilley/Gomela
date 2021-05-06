
// https://github.com/hashicorp/vault/blob/master/plugins/database/cassandra/cassandra_test.go#L251
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_connect2510 = [1] of {int};
	run connect251(child_connect2510)
stop_process:skip
}

proctype connect251(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close1530 = [1] of {int};
	Mutexdef session_closeMu;
	Mutexdef session_schemaEvents_mu;
	Mutexdef session_nodeEvents_mu;
	Mutexdef session_mu;
	Mutexdef session_metadata_mu;
	Mutexdef session_ring_mu;
	Mutexdef session_pool_mu;
	Mutexdef session_executor_pool_mu;
	Mutexdef session_connCfg_tlsConfig_mutex;
	Mutexdef session_stmtsLRU_mu;
	Mutexdef session_hostSource_mu;
	Mutexdef session_schemaDescriber_mu;
	Mutexdef session_routingKeyInfoCache_mu;
	run mutexMonitor(session_routingKeyInfoCache_mu);
	run mutexMonitor(session_schemaDescriber_mu);
	run mutexMonitor(session_hostSource_mu);
	run mutexMonitor(session_stmtsLRU_mu);
	run mutexMonitor(session_connCfg_tlsConfig_mutex);
	run mutexMonitor(session_executor_pool_mu);
	run mutexMonitor(session_pool_mu);
	run mutexMonitor(session_ring_mu);
	run mutexMonitor(session_metadata_mu);
	run mutexMonitor(session_mu);
	run mutexMonitor(session_nodeEvents_mu);
	run mutexMonitor(session_schemaEvents_mu);
	run mutexMonitor(session_closeMu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
		run Close153(session_routingKeyInfoCache_mu,session_schemaDescriber_mu,session_hostSource_mu,session_stmtsLRU_mu,session_connCfg_tlsConfig_mutex,session_executor_pool_mu,session_pool_mu,session_ring_mu,session_metadata_mu,session_mu,session_nodeEvents_mu,session_schemaEvents_mu,session_closeMu,child_Close1530);
	child_Close1530?0;
	child!0
}
proctype Close153(Mutexdef c_routingKeyInfoCache_mu;Mutexdef c_schemaDescriber_mu;Mutexdef c_hostSource_mu;Mutexdef c_stmtsLRU_mu;Mutexdef c_connCfg_tlsConfig_mutex;Mutexdef c_executor_pool_mu;Mutexdef c_pool_mu;Mutexdef c_ring_mu;Mutexdef c_metadata_mu;Mutexdef c_mu;Mutexdef c_nodeEvents_mu;Mutexdef c_schemaEvents_mu;Mutexdef c_closeMu;chan child) {
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

