
// https://github.com/istio/istio/blob/master/pilot/pkg/xds/eds_test.go#L423
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
	chan child_TestDeleteService4230 = [1] of {int};
	run TestDeleteService423(child_TestDeleteService4230)
stop_process:skip
}

proctype TestDeleteService423(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_testEndpoints4921 = [1] of {int};
	Mutexdef adscConn_Locality_state_atomicMessageInfo_initMu;
	Mutexdef adscConn_cfg_Locality_state_atomicMessageInfo_initMu;
	Mutexdef adscConn_cfg_Meta_state_atomicMessageInfo_initMu;
	Wgdef adscConn_RecvWg;
	Mutexdef adscConn_Registry_mutex;
	Mutexdef adscConn_mutex;
	Mutexdef adscConn_Metadata_state_atomicMessageInfo_initMu;
	Mutexdef adscConn_conn_lceMu;
	Mutexdef adscConn_conn_firstResolveEvent_o_m;
	Mutexdef adscConn_conn_balancerWrapper_mu;
	Mutexdef adscConn_conn_balancerWrapper_done_o_m;
	Mutexdef adscConn_conn_balancerWrapper_scBuffer_mu;
	Mutexdef adscConn_conn_balancerWrapper_balancerMu;
	Mutexdef adscConn_conn_resolverWrapper_pollingMu;
	Mutexdef adscConn_conn_resolverWrapper_done_o_m;
	Mutexdef adscConn_conn_resolverWrapper_resolverMu;
	Mutexdef adscConn_conn_mu;
	Mutexdef adscConn_conn_safeConfigSelector_mu;
	Mutexdef adscConn_conn_blockingpicker_mu;
	Mutexdef adscConn_conn_csMgr_mu;
	chan child_addEdsCluster9280 = [1] of {int};
	Mutexdef s_Listener_mu;
	Mutexdef s_Discovery_JwtKeyResolver_keyEntries_mu;
	Mutexdef s_Discovery_WorkloadEntryController_mutex;
	Mutexdef s_Discovery_WorkloadEntryController_cleanupLimit_mu;
	Mutexdef s_Discovery_adsClientsMutex;
	Mutexdef s_Discovery_updateMutex;
	Mutexdef s_Discovery_mutex;
	Mutexdef s_Discovery_MemRegistry_mutex;
	Mutexdef s_Discovery_Env_TrustBundle_endpointMutex;
	Mutexdef s_Discovery_Env_TrustBundle_mutex;
	Mutexdef s_Discovery_Env_PushContext_initializeMutex;
	Mutexdef s_Discovery_Env_PushContext_networksMu;
	Mutexdef s_Discovery_Env_PushContext_JwtKeyResolver_keyEntries_mu;
	Mutexdef s_Discovery_Env_PushContext_proxyStatusMutex;
	run mutexMonitor(s_Discovery_Env_PushContext_proxyStatusMutex);
	run mutexMonitor(s_Discovery_Env_PushContext_JwtKeyResolver_keyEntries_mu);
	run mutexMonitor(s_Discovery_Env_PushContext_networksMu);
	run mutexMonitor(s_Discovery_Env_PushContext_initializeMutex);
	run mutexMonitor(s_Discovery_Env_TrustBundle_mutex);
	run mutexMonitor(s_Discovery_Env_TrustBundle_endpointMutex);
	run mutexMonitor(s_Discovery_MemRegistry_mutex);
	run mutexMonitor(s_Discovery_mutex);
	run mutexMonitor(s_Discovery_updateMutex);
	run mutexMonitor(s_Discovery_adsClientsMutex);
	run mutexMonitor(s_Discovery_WorkloadEntryController_cleanupLimit_mu);
	run mutexMonitor(s_Discovery_WorkloadEntryController_mutex);
	run mutexMonitor(s_Discovery_JwtKeyResolver_keyEntries_mu);
	run mutexMonitor(s_Listener_mu);
	run addEdsCluster928(s_Discovery_Env_PushContext_proxyStatusMutex,s_Discovery_Env_PushContext_JwtKeyResolver_keyEntries_mu,s_Discovery_Env_PushContext_networksMu,s_Discovery_Env_PushContext_initializeMutex,s_Discovery_Env_TrustBundle_mutex,s_Discovery_Env_TrustBundle_endpointMutex,s_Discovery_MemRegistry_mutex,s_Discovery_mutex,s_Discovery_updateMutex,s_Discovery_adsClientsMutex,s_Discovery_WorkloadEntryController_cleanupLimit_mu,s_Discovery_WorkloadEntryController_mutex,s_Discovery_JwtKeyResolver_keyEntries_mu,s_Listener_mu,child_addEdsCluster9280);
	child_addEdsCluster9280?0;
	run mutexMonitor(adscConn_conn_csMgr_mu);
	run mutexMonitor(adscConn_conn_blockingpicker_mu);
	run mutexMonitor(adscConn_conn_safeConfigSelector_mu);
	run mutexMonitor(adscConn_conn_mu);
	run mutexMonitor(adscConn_conn_resolverWrapper_resolverMu);
	run mutexMonitor(adscConn_conn_resolverWrapper_done_o_m);
	run mutexMonitor(adscConn_conn_resolverWrapper_pollingMu);
	run mutexMonitor(adscConn_conn_balancerWrapper_balancerMu);
	run mutexMonitor(adscConn_conn_balancerWrapper_scBuffer_mu);
	run mutexMonitor(adscConn_conn_balancerWrapper_done_o_m);
	run mutexMonitor(adscConn_conn_balancerWrapper_mu);
	run mutexMonitor(adscConn_conn_firstResolveEvent_o_m);
	run mutexMonitor(adscConn_conn_lceMu);
	run mutexMonitor(adscConn_Metadata_state_atomicMessageInfo_initMu);
	run mutexMonitor(adscConn_mutex);
	run mutexMonitor(adscConn_Registry_mutex);
	run wgMonitor(adscConn_RecvWg);
	run mutexMonitor(adscConn_cfg_Meta_state_atomicMessageInfo_initMu);
	run mutexMonitor(adscConn_cfg_Locality_state_atomicMessageInfo_initMu);
	run mutexMonitor(adscConn_Locality_state_atomicMessageInfo_initMu);
	run testEndpoints492(adscConn_RecvWg,adscConn_conn_csMgr_mu,adscConn_conn_blockingpicker_mu,adscConn_conn_safeConfigSelector_mu,adscConn_conn_mu,adscConn_conn_resolverWrapper_resolverMu,adscConn_conn_resolverWrapper_done_o_m,adscConn_conn_resolverWrapper_pollingMu,adscConn_conn_balancerWrapper_balancerMu,adscConn_conn_balancerWrapper_scBuffer_mu,adscConn_conn_balancerWrapper_done_o_m,adscConn_conn_balancerWrapper_mu,adscConn_conn_firstResolveEvent_o_m,adscConn_conn_lceMu,adscConn_Metadata_state_atomicMessageInfo_initMu,adscConn_mutex,adscConn_Registry_mutex,adscConn_cfg_Meta_state_atomicMessageInfo_initMu,adscConn_cfg_Locality_state_atomicMessageInfo_initMu,adscConn_Locality_state_atomicMessageInfo_initMu,child_testEndpoints4921);
	child_testEndpoints4921?0;
	stop_process: skip;
	child!0
}
proctype addEdsCluster928(Mutexdef s_Discovery_Env_PushContext_proxyStatusMutex;Mutexdef s_Discovery_Env_PushContext_JwtKeyResolver_keyEntries_mu;Mutexdef s_Discovery_Env_PushContext_networksMu;Mutexdef s_Discovery_Env_PushContext_initializeMutex;Mutexdef s_Discovery_Env_TrustBundle_mutex;Mutexdef s_Discovery_Env_TrustBundle_endpointMutex;Mutexdef s_Discovery_MemRegistry_mutex;Mutexdef s_Discovery_mutex;Mutexdef s_Discovery_updateMutex;Mutexdef s_Discovery_adsClientsMutex;Mutexdef s_Discovery_WorkloadEntryController_cleanupLimit_mu;Mutexdef s_Discovery_WorkloadEntryController_mutex;Mutexdef s_Discovery_JwtKeyResolver_keyEntries_mu;Mutexdef s_Listener_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_fullPush4400 = [1] of {int};
	run fullPush440(s_Discovery_Env_PushContext_proxyStatusMutex,s_Discovery_Env_PushContext_JwtKeyResolver_keyEntries_mu,s_Discovery_Env_PushContext_networksMu,s_Discovery_Env_PushContext_initializeMutex,s_Discovery_Env_TrustBundle_mutex,s_Discovery_Env_TrustBundle_endpointMutex,s_Discovery_MemRegistry_mutex,s_Discovery_mutex,s_Discovery_updateMutex,s_Discovery_adsClientsMutex,s_Discovery_WorkloadEntryController_cleanupLimit_mu,s_Discovery_WorkloadEntryController_mutex,s_Discovery_JwtKeyResolver_keyEntries_mu,s_Listener_mu,child_fullPush4400);
	child_fullPush4400?0;
	stop_process: skip;
	child!0
}
proctype fullPush440(Mutexdef s_Discovery_Env_PushContext_proxyStatusMutex;Mutexdef s_Discovery_Env_PushContext_JwtKeyResolver_keyEntries_mu;Mutexdef s_Discovery_Env_PushContext_networksMu;Mutexdef s_Discovery_Env_PushContext_initializeMutex;Mutexdef s_Discovery_Env_TrustBundle_mutex;Mutexdef s_Discovery_Env_TrustBundle_endpointMutex;Mutexdef s_Discovery_MemRegistry_mutex;Mutexdef s_Discovery_mutex;Mutexdef s_Discovery_updateMutex;Mutexdef s_Discovery_adsClientsMutex;Mutexdef s_Discovery_WorkloadEntryController_cleanupLimit_mu;Mutexdef s_Discovery_WorkloadEntryController_mutex;Mutexdef s_Discovery_JwtKeyResolver_keyEntries_mu;Mutexdef s_Listener_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype testEndpoints492(Wgdef adsc_RecvWg;Mutexdef adsc_conn_csMgr_mu;Mutexdef adsc_conn_blockingpicker_mu;Mutexdef adsc_conn_safeConfigSelector_mu;Mutexdef adsc_conn_mu;Mutexdef adsc_conn_resolverWrapper_resolverMu;Mutexdef adsc_conn_resolverWrapper_done_o_m;Mutexdef adsc_conn_resolverWrapper_pollingMu;Mutexdef adsc_conn_balancerWrapper_balancerMu;Mutexdef adsc_conn_balancerWrapper_scBuffer_mu;Mutexdef adsc_conn_balancerWrapper_done_o_m;Mutexdef adsc_conn_balancerWrapper_mu;Mutexdef adsc_conn_firstResolveEvent_o_m;Mutexdef adsc_conn_lceMu;Mutexdef adsc_Metadata_state_atomicMessageInfo_initMu;Mutexdef adsc_mutex;Mutexdef adsc_Registry_mutex;Mutexdef adsc_cfg_Meta_state_atomicMessageInfo_initMu;Mutexdef adsc_cfg_Locality_state_atomicMessageInfo_initMu;Mutexdef adsc_Locality_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef lbe_Policy_EndpointStaleAfter_state_atomicMessageInfo_initMu;
	Mutexdef lbe_Policy_OverprovisioningFactor_state_atomicMessageInfo_initMu;
	Mutexdef lbe_Policy_state_atomicMessageInfo_initMu;
	Mutexdef lbe_state_atomicMessageInfo_initMu;
	run mutexMonitor(lbe_state_atomicMessageInfo_initMu);
	run mutexMonitor(lbe_Policy_state_atomicMessageInfo_initMu);
	run mutexMonitor(lbe_Policy_OverprovisioningFactor_state_atomicMessageInfo_initMu);
	run mutexMonitor(lbe_Policy_EndpointStaleAfter_state_atomicMessageInfo_initMu);
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

