
// https://github.com/kubernetes/kubernetes/blob/master/test/integration/client/exec_test.go#L444
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestExecPluginViaInformer4440 = [1] of {int};
	run TestExecPluginViaInformer444(child_TestExecPluginViaInformer4440)
stop_process:skip
}

proctype TestExecPluginViaInformer444(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef result_EtcdClient_mu;
	Mutexdef result_EtcdClient_resolverGroup_mu;
	Mutexdef result_EtcdClient_cfg_TLS_mutex;
	Mutexdef result_EtcdClient_conn_firstResolveEvent_o_m;
	Mutexdef result_EtcdClient_conn_balancerWrapper_mu;
	Mutexdef result_EtcdClient_conn_balancerWrapper_done_o_m;
	Mutexdef result_EtcdClient_conn_balancerWrapper_scBuffer_mu;
	Mutexdef result_EtcdClient_conn_balancerWrapper_balancerMu;
	Mutexdef result_EtcdClient_conn_resolverWrapper_pollingMu;
	Mutexdef result_EtcdClient_conn_resolverWrapper_done_o_m;
	Mutexdef result_EtcdClient_conn_resolverWrapper_resolverMu;
	Mutexdef result_EtcdClient_conn_mu;
	Mutexdef result_EtcdClient_conn_blockingpicker_mu;
	Mutexdef result_EtcdClient_conn_csMgr_mu;
	Mutexdef result_ServerOpts_Admission_GenericAdmission_Plugins_lock;
	run mutexMonitor(result_ServerOpts_Admission_GenericAdmission_Plugins_lock);
	run mutexMonitor(result_EtcdClient_conn_csMgr_mu);
	run mutexMonitor(result_EtcdClient_conn_blockingpicker_mu);
	run mutexMonitor(result_EtcdClient_conn_mu);
	run mutexMonitor(result_EtcdClient_conn_resolverWrapper_resolverMu);
	run mutexMonitor(result_EtcdClient_conn_resolverWrapper_done_o_m);
	run mutexMonitor(result_EtcdClient_conn_resolverWrapper_pollingMu);
	run mutexMonitor(result_EtcdClient_conn_balancerWrapper_balancerMu);
	run mutexMonitor(result_EtcdClient_conn_balancerWrapper_scBuffer_mu);
	run mutexMonitor(result_EtcdClient_conn_balancerWrapper_done_o_m);
	run mutexMonitor(result_EtcdClient_conn_balancerWrapper_mu);
	run mutexMonitor(result_EtcdClient_conn_firstResolveEvent_o_m);
	run mutexMonitor(result_EtcdClient_cfg_TLS_mutex);
	run mutexMonitor(result_EtcdClient_resolverGroup_mu);
	run mutexMonitor(result_EtcdClient_mu);
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

