
// https://github.com/hashicorp/vault/blob/master/plugins/database/cassandra/cassandra.go#L43
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_new430 = [1] of {int};
	run new43(child_new430)
stop_process:skip
}

proctype new43(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef connProducer_session_closeMu;
	Mutexdef connProducer_session_schemaEvents_mu;
	Mutexdef connProducer_session_nodeEvents_mu;
	Mutexdef connProducer_session_mu;
	Mutexdef connProducer_session_metadata_mu;
	Mutexdef connProducer_session_ring_mu;
	Mutexdef connProducer_session_pool_mu;
	Mutexdef connProducer_session_executor_pool_mu;
	Mutexdef connProducer_session_connCfg_tlsConfig_mutex;
	Mutexdef connProducer_session_stmtsLRU_mu;
	Mutexdef connProducer_session_hostSource_mu;
	Mutexdef connProducer_session_schemaDescriber_mu;
	Mutexdef connProducer_session_routingKeyInfoCache_mu;
	run mutexMonitor(connProducer_session_routingKeyInfoCache_mu);
	run mutexMonitor(connProducer_session_schemaDescriber_mu);
	run mutexMonitor(connProducer_session_hostSource_mu);
	run mutexMonitor(connProducer_session_stmtsLRU_mu);
	run mutexMonitor(connProducer_session_connCfg_tlsConfig_mutex);
	run mutexMonitor(connProducer_session_executor_pool_mu);
	run mutexMonitor(connProducer_session_pool_mu);
	run mutexMonitor(connProducer_session_ring_mu);
	run mutexMonitor(connProducer_session_metadata_mu);
	run mutexMonitor(connProducer_session_mu);
	run mutexMonitor(connProducer_session_nodeEvents_mu);
	run mutexMonitor(connProducer_session_schemaEvents_mu);
	run mutexMonitor(connProducer_session_closeMu);
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

