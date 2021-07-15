
// https://github.com/hashicorp/vault/blob/master/builtin/logical/database/backend_test.go#L147
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBackend_config_connection1470 = [1] of {int};
	run TestBackend_config_connection147(child_TestBackend_config_connection1470)
stop_process:skip
}

proctype TestBackend_config_connection147(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef req_Auth_Alias_state_atomicMessageInfo_initMu;
	Mutexdef b_credRotationQueue_lock;
	Mutexdef cluster_base_MetricsHelper_LoopMetrics_Metrics_mu;
	Mutexdef cluster_base_MetricsHelper_inMemSink_intervalLock;
	Mutexdef cluster_base_ReloadFuncsLock;
	Mutexdef resp_Auth_Alias_state_atomicMessageInfo_initMu;
	run mutexMonitor(resp_Auth_Alias_state_atomicMessageInfo_initMu);
	run mutexMonitor(cluster_base_ReloadFuncsLock);
	run mutexMonitor(cluster_base_MetricsHelper_inMemSink_intervalLock);
	run mutexMonitor(cluster_base_MetricsHelper_LoopMetrics_Metrics_mu);
	run mutexMonitor(b_credRotationQueue_lock);
	run mutexMonitor(req_Auth_Alias_state_atomicMessageInfo_initMu);
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

