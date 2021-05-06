
// https://github.com/istio/istio/blob/master/pilot/pkg/xds/eds_test.go#L58
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
	chan child_TestIncrementalPush580 = [1] of {int};
	run TestIncrementalPush58(child_TestIncrementalPush580)
stop_process:skip
}

proctype TestIncrementalPush58(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef ads_Locality_state_atomicMessageInfo_initMu;
	Mutexdef ads_cfg_Locality_state_atomicMessageInfo_initMu;
	Mutexdef ads_cfg_Meta_state_atomicMessageInfo_initMu;
	Wgdef ads_RecvWg;
	Mutexdef ads_Registry_mutex;
	Mutexdef ads_mutex;
	Mutexdef ads_Metadata_state_atomicMessageInfo_initMu;
	Mutexdef ads_conn_lceMu;
	Mutexdef ads_conn_firstResolveEvent_o_m;
	Mutexdef ads_conn_balancerWrapper_mu;
	Mutexdef ads_conn_balancerWrapper_done_o_m;
	Mutexdef ads_conn_balancerWrapper_scBuffer_mu;
	Mutexdef ads_conn_balancerWrapper_balancerMu;
	Mutexdef ads_conn_resolverWrapper_pollingMu;
	Mutexdef ads_conn_resolverWrapper_done_o_m;
	Mutexdef ads_conn_resolverWrapper_resolverMu;
	Mutexdef ads_conn_mu;
	Mutexdef ads_conn_safeConfigSelector_mu;
	Mutexdef ads_conn_blockingpicker_mu;
	Mutexdef ads_conn_csMgr_mu;
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
	run mutexMonitor(ads_conn_csMgr_mu);
	run mutexMonitor(ads_conn_blockingpicker_mu);
	run mutexMonitor(ads_conn_safeConfigSelector_mu);
	run mutexMonitor(ads_conn_mu);
	run mutexMonitor(ads_conn_resolverWrapper_resolverMu);
	run mutexMonitor(ads_conn_resolverWrapper_done_o_m);
	run mutexMonitor(ads_conn_resolverWrapper_pollingMu);
	run mutexMonitor(ads_conn_balancerWrapper_balancerMu);
	run mutexMonitor(ads_conn_balancerWrapper_scBuffer_mu);
	run mutexMonitor(ads_conn_balancerWrapper_done_o_m);
	run mutexMonitor(ads_conn_balancerWrapper_mu);
	run mutexMonitor(ads_conn_firstResolveEvent_o_m);
	run mutexMonitor(ads_conn_lceMu);
	run mutexMonitor(ads_Metadata_state_atomicMessageInfo_initMu);
	run mutexMonitor(ads_mutex);
	run mutexMonitor(ads_Registry_mutex);
	run wgMonitor(ads_RecvWg);
	run mutexMonitor(ads_cfg_Meta_state_atomicMessageInfo_initMu);
	run mutexMonitor(ads_cfg_Locality_state_atomicMessageInfo_initMu);
	run mutexMonitor(ads_Locality_state_atomicMessageInfo_initMu);
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

