
// https://github.com/kubernetes/kubernetes/blob/master/pkg/controlplane/instance_test.go#L144
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestLegacyRestStorageStrategies1440 = [1] of {int};
	run TestLegacyRestStorageStrategies144(child_TestLegacyRestStorageStrategies1440)
stop_process:skip
}

proctype TestLegacyRestStorageStrategies144(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef apiserverCfg_GenericConfig_HandlerChainWaitGroup_mu;
	Wgdef apiserverCfg_GenericConfig_HandlerChainWaitGroup_wg;
	Mutexdef etcdserver_V3Client_mu;
	Mutexdef etcdserver_V3Client_resolverGroup_mu;
	Mutexdef etcdserver_V3Client_cfg_TLS_mutex;
	Mutexdef etcdserver_V3Client_conn_firstResolveEvent_o_m;
	Mutexdef etcdserver_V3Client_conn_balancerWrapper_mu;
	Mutexdef etcdserver_V3Client_conn_balancerWrapper_done_o_m;
	Mutexdef etcdserver_V3Client_conn_balancerWrapper_scBuffer_mu;
	Mutexdef etcdserver_V3Client_conn_balancerWrapper_balancerMu;
	Mutexdef etcdserver_V3Client_conn_resolverWrapper_pollingMu;
	Mutexdef etcdserver_V3Client_conn_resolverWrapper_done_o_m;
	Mutexdef etcdserver_V3Client_conn_resolverWrapper_resolverMu;
	Mutexdef etcdserver_V3Client_conn_mu;
	Mutexdef etcdserver_V3Client_conn_blockingpicker_mu;
	Mutexdef etcdserver_V3Client_conn_csMgr_mu;
	Mutexdef etcdserver_v3Cluster_mu;
	Mutexdef etcdserver_s_leadTimeMu;
	Wgdef etcdserver_s_wg;
	Mutexdef etcdserver_s_wgMu;
	Mutexdef etcdserver_s_alarmStore_mu;
	Mutexdef etcdserver_s_bemu;
	Mutexdef etcdserver_s_leaderChangedMu;
	Mutexdef etcdserver_s_readMu;
	Mutexdef etcdserver_s_lgMu;
	Mutexdef etcdserver_s_r_td_mu;
	Mutexdef etcdserver_s_r_tickMu;
	Mutexdef __GenericAPIServer_HandlerChainWaitGroup_mu;
	Wgdef __GenericAPIServer_HandlerChainWaitGroup_wg;
	Mutexdef __GenericAPIServer_readyzLock;
	Mutexdef __GenericAPIServer_livezLock;
	Mutexdef __GenericAPIServer_healthzLock;
	Mutexdef __GenericAPIServer_preShutdownHookLock;
	Mutexdef __GenericAPIServer_postStartHookLock;
	Mutexdef __GenericAPIServer_OpenAPIVersionedService_rwMutex;
	Mutexdef __GenericAPIServer_Handler_NonGoRestfulMux_lock;
	Mutexdef __GenericAPIServer_Handler_GoRestfulContainer_ServeMux_mu;
	Mutexdef __GenericAPIServer_Handler_GoRestfulContainer_webServicesLock;
	run mutexMonitor(__GenericAPIServer_Handler_GoRestfulContainer_webServicesLock);
	run mutexMonitor(__GenericAPIServer_Handler_GoRestfulContainer_ServeMux_mu);
	run mutexMonitor(__GenericAPIServer_Handler_NonGoRestfulMux_lock);
	run mutexMonitor(__GenericAPIServer_OpenAPIVersionedService_rwMutex);
	run mutexMonitor(__GenericAPIServer_postStartHookLock);
	run mutexMonitor(__GenericAPIServer_preShutdownHookLock);
	run mutexMonitor(__GenericAPIServer_healthzLock);
	run mutexMonitor(__GenericAPIServer_livezLock);
	run mutexMonitor(__GenericAPIServer_readyzLock);
	run wgMonitor(__GenericAPIServer_HandlerChainWaitGroup_wg);
	run mutexMonitor(__GenericAPIServer_HandlerChainWaitGroup_mu);
	run mutexMonitor(etcdserver_s_r_tickMu);
	run mutexMonitor(etcdserver_s_r_td_mu);
	run mutexMonitor(etcdserver_s_lgMu);
	run mutexMonitor(etcdserver_s_readMu);
	run mutexMonitor(etcdserver_s_leaderChangedMu);
	run mutexMonitor(etcdserver_s_bemu);
	run mutexMonitor(etcdserver_s_alarmStore_mu);
	run mutexMonitor(etcdserver_s_wgMu);
	run wgMonitor(etcdserver_s_wg);
	run mutexMonitor(etcdserver_s_leadTimeMu);
	run mutexMonitor(etcdserver_v3Cluster_mu);
	run mutexMonitor(etcdserver_V3Client_conn_csMgr_mu);
	run mutexMonitor(etcdserver_V3Client_conn_blockingpicker_mu);
	run mutexMonitor(etcdserver_V3Client_conn_mu);
	run mutexMonitor(etcdserver_V3Client_conn_resolverWrapper_resolverMu);
	run mutexMonitor(etcdserver_V3Client_conn_resolverWrapper_done_o_m);
	run mutexMonitor(etcdserver_V3Client_conn_resolverWrapper_pollingMu);
	run mutexMonitor(etcdserver_V3Client_conn_balancerWrapper_balancerMu);
	run mutexMonitor(etcdserver_V3Client_conn_balancerWrapper_scBuffer_mu);
	run mutexMonitor(etcdserver_V3Client_conn_balancerWrapper_done_o_m);
	run mutexMonitor(etcdserver_V3Client_conn_balancerWrapper_mu);
	run mutexMonitor(etcdserver_V3Client_conn_firstResolveEvent_o_m);
	run mutexMonitor(etcdserver_V3Client_cfg_TLS_mutex);
	run mutexMonitor(etcdserver_V3Client_resolverGroup_mu);
	run mutexMonitor(etcdserver_V3Client_mu);
	run wgMonitor(apiserverCfg_GenericConfig_HandlerChainWaitGroup_wg);
	run mutexMonitor(apiserverCfg_GenericConfig_HandlerChainWaitGroup_mu);
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

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

