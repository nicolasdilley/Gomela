
// https://github.com/istio/istio/blob/master/pilot/pkg/xds/ads_test.go#L141
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAdsBadId1410 = [1] of {int};
	run TestAdsBadId141(child_TestAdsBadId1410)
stop_process:skip
}

proctype TestAdsBadId141(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AdsPushAll8390 = [1] of {int};
	Mutexdef ads_cancelOnce_m;
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
	run mutexMonitor(ads_cancelOnce_m);
	run AdsPushAll839(s_Discovery_Env_PushContext_proxyStatusMutex,s_Discovery_Env_PushContext_JwtKeyResolver_keyEntries_mu,s_Discovery_Env_PushContext_networksMu,s_Discovery_Env_PushContext_initializeMutex,s_Discovery_Env_TrustBundle_mutex,s_Discovery_Env_TrustBundle_endpointMutex,s_Discovery_MemRegistry_mutex,s_Discovery_mutex,s_Discovery_updateMutex,s_Discovery_adsClientsMutex,s_Discovery_WorkloadEntryController_cleanupLimit_mu,s_Discovery_WorkloadEntryController_mutex,s_Discovery_JwtKeyResolver_keyEntries_mu,child_AdsPushAll8390);
	child_AdsPushAll8390?0;
	stop_process: skip;
	child!0
}
proctype AdsPushAll839(Mutexdef s_Env_PushContext_proxyStatusMutex;Mutexdef s_Env_PushContext_JwtKeyResolver_keyEntries_mu;Mutexdef s_Env_PushContext_networksMu;Mutexdef s_Env_PushContext_initializeMutex;Mutexdef s_Env_TrustBundle_mutex;Mutexdef s_Env_TrustBundle_endpointMutex;Mutexdef s_MemRegistry_mutex;Mutexdef s_mutex;Mutexdef s_updateMutex;Mutexdef s_adsClientsMutex;Mutexdef s_WorkloadEntryController_cleanupLimit_mu;Mutexdef s_WorkloadEntryController_mutex;Mutexdef s_JwtKeyResolver_keyEntries_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AdsPushAll8500 = [1] of {int};
	run AdsPushAll850(s_Env_PushContext_proxyStatusMutex,s_Env_PushContext_JwtKeyResolver_keyEntries_mu,s_Env_PushContext_networksMu,s_Env_PushContext_initializeMutex,s_Env_TrustBundle_mutex,s_Env_TrustBundle_endpointMutex,s_MemRegistry_mutex,s_mutex,s_updateMutex,s_adsClientsMutex,s_WorkloadEntryController_cleanupLimit_mu,s_WorkloadEntryController_mutex,s_JwtKeyResolver_keyEntries_mu,child_AdsPushAll8500);
	child_AdsPushAll8500?0;
	stop_process: skip;
	child!0
}
proctype AdsPushAll850(Mutexdef s_Env_PushContext_proxyStatusMutex;Mutexdef s_Env_PushContext_JwtKeyResolver_keyEntries_mu;Mutexdef s_Env_PushContext_networksMu;Mutexdef s_Env_PushContext_initializeMutex;Mutexdef s_Env_TrustBundle_mutex;Mutexdef s_Env_TrustBundle_endpointMutex;Mutexdef s_MemRegistry_mutex;Mutexdef s_mutex;Mutexdef s_updateMutex;Mutexdef s_adsClientsMutex;Mutexdef s_WorkloadEntryController_cleanupLimit_mu;Mutexdef s_WorkloadEntryController_mutex;Mutexdef s_JwtKeyResolver_keyEntries_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_startPush8772 = [1] of {int};
	chan child_adsClientCount8030 = [1] of {int};
	chan child_adsClientCount8031 = [1] of {int};
	

	if
	:: true -> 
		run adsClientCount803(s_Env_PushContext_proxyStatusMutex,s_Env_PushContext_JwtKeyResolver_keyEntries_mu,s_Env_PushContext_networksMu,s_Env_PushContext_initializeMutex,s_Env_TrustBundle_mutex,s_Env_TrustBundle_endpointMutex,s_MemRegistry_mutex,s_mutex,s_updateMutex,s_adsClientsMutex,s_WorkloadEntryController_cleanupLimit_mu,s_WorkloadEntryController_mutex,s_JwtKeyResolver_keyEntries_mu,child_adsClientCount8030);
		child_adsClientCount8030?0
	:: true -> 
		run adsClientCount803(s_Env_PushContext_proxyStatusMutex,s_Env_PushContext_JwtKeyResolver_keyEntries_mu,s_Env_PushContext_networksMu,s_Env_PushContext_initializeMutex,s_Env_TrustBundle_mutex,s_Env_TrustBundle_endpointMutex,s_MemRegistry_mutex,s_mutex,s_updateMutex,s_adsClientsMutex,s_WorkloadEntryController_cleanupLimit_mu,s_WorkloadEntryController_mutex,s_JwtKeyResolver_keyEntries_mu,child_adsClientCount8031);
		child_adsClientCount8031?0
	fi;
	run startPush877(s_Env_PushContext_proxyStatusMutex,s_Env_PushContext_JwtKeyResolver_keyEntries_mu,s_Env_PushContext_networksMu,s_Env_PushContext_initializeMutex,s_Env_TrustBundle_mutex,s_Env_TrustBundle_endpointMutex,s_MemRegistry_mutex,s_mutex,s_updateMutex,s_adsClientsMutex,s_WorkloadEntryController_cleanupLimit_mu,s_WorkloadEntryController_mutex,s_JwtKeyResolver_keyEntries_mu,child_startPush8772);
	child_startPush8772?0;
	stop_process: skip;
	child!0
}
proctype adsClientCount803(Mutexdef s_Env_PushContext_proxyStatusMutex;Mutexdef s_Env_PushContext_JwtKeyResolver_keyEntries_mu;Mutexdef s_Env_PushContext_networksMu;Mutexdef s_Env_PushContext_initializeMutex;Mutexdef s_Env_TrustBundle_mutex;Mutexdef s_Env_TrustBundle_endpointMutex;Mutexdef s_MemRegistry_mutex;Mutexdef s_mutex;Mutexdef s_updateMutex;Mutexdef s_adsClientsMutex;Mutexdef s_WorkloadEntryController_cleanupLimit_mu;Mutexdef s_WorkloadEntryController_mutex;Mutexdef s_JwtKeyResolver_keyEntries_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_adsClientsMutex.RLock!false;
	goto stop_process;
	stop_process: skip;
		s_adsClientsMutex.RUnlock!false;
	child!0
}
proctype startPush877(Mutexdef s_Env_PushContext_proxyStatusMutex;Mutexdef s_Env_PushContext_JwtKeyResolver_keyEntries_mu;Mutexdef s_Env_PushContext_networksMu;Mutexdef s_Env_PushContext_initializeMutex;Mutexdef s_Env_TrustBundle_mutex;Mutexdef s_Env_TrustBundle_endpointMutex;Mutexdef s_MemRegistry_mutex;Mutexdef s_mutex;Mutexdef s_updateMutex;Mutexdef s_adsClientsMutex;Mutexdef s_WorkloadEntryController_cleanupLimit_mu;Mutexdef s_WorkloadEntryController_mutex;Mutexdef s_JwtKeyResolver_keyEntries_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

