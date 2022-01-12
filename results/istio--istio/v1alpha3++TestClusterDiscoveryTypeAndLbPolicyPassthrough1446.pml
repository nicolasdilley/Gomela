// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/istio/istio/blob//pilot/pkg/networking/core/v1alpha3/cluster_test.go#L1446
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestClusterDiscoveryTypeAndLbPolicyPassthrough14460 = [1] of {int};
	run TestClusterDiscoveryTypeAndLbPolicyPassthrough1446(child_TestClusterDiscoveryTypeAndLbPolicyPassthrough14460);
	run receiver(child_TestClusterDiscoveryTypeAndLbPolicyPassthrough14460)
stop_process:skip
}

proctype TestClusterDiscoveryTypeAndLbPolicyPassthrough1446(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef c_HiddenEnvoyDeprecatedTlsContext_state_atomicMessageInfo_initMu;
	Mutexdef c_PreconnectPolicy_state_atomicMessageInfo_initMu;
	Mutexdef c_TrackClusterStats_state_atomicMessageInfo_initMu;
	Mutexdef c_UpstreamConfig_state_atomicMessageInfo_initMu;
	Mutexdef c_LrsServer_state_atomicMessageInfo_initMu;
	Mutexdef c_LoadBalancingPolicy_state_atomicMessageInfo_initMu;
	Mutexdef c_UpstreamConnectionOptions_state_atomicMessageInfo_initMu;
	Mutexdef c_Metadata_state_atomicMessageInfo_initMu;
	Mutexdef c_TransportSocket_state_atomicMessageInfo_initMu;
	Mutexdef c_CommonLbConfig_state_atomicMessageInfo_initMu;
	Mutexdef c_LbSubsetConfig_state_atomicMessageInfo_initMu;
	Mutexdef c_UpstreamBindConfig_state_atomicMessageInfo_initMu;
	Mutexdef c_CleanupInterval_state_atomicMessageInfo_initMu;
	Mutexdef c_OutlierDetection_state_atomicMessageInfo_initMu;
	Mutexdef c_DnsFailureRefreshRate_state_atomicMessageInfo_initMu;
	Mutexdef c_DnsRefreshRate_state_atomicMessageInfo_initMu;
	Mutexdef c_Http2ProtocolOptions_state_atomicMessageInfo_initMu;
	Mutexdef c_HttpProtocolOptions_state_atomicMessageInfo_initMu;
	Mutexdef c_CommonHttpProtocolOptions_state_atomicMessageInfo_initMu;
	Mutexdef c_UpstreamHttpProtocolOptions_state_atomicMessageInfo_initMu;
	Mutexdef c_CircuitBreakers_state_atomicMessageInfo_initMu;
	Mutexdef c_MaxRequestsPerConnection_state_atomicMessageInfo_initMu;
	Mutexdef c_LoadAssignment_state_atomicMessageInfo_initMu;
	Mutexdef c_PerConnectionBufferLimitBytes_state_atomicMessageInfo_initMu;
	Mutexdef c_ConnectTimeout_state_atomicMessageInfo_initMu;
	Mutexdef c_EdsClusterConfig_state_atomicMessageInfo_initMu;
	Mutexdef c_state_atomicMessageInfo_initMu;
	run mutexMonitor(c_state_atomicMessageInfo_initMu);
	run mutexMonitor(c_EdsClusterConfig_state_atomicMessageInfo_initMu);
	run mutexMonitor(c_ConnectTimeout_state_atomicMessageInfo_initMu);
	run mutexMonitor(c_PerConnectionBufferLimitBytes_state_atomicMessageInfo_initMu);
	run mutexMonitor(c_LoadAssignment_state_atomicMessageInfo_initMu);
	run mutexMonitor(c_MaxRequestsPerConnection_state_atomicMessageInfo_initMu);
	run mutexMonitor(c_CircuitBreakers_state_atomicMessageInfo_initMu);
	run mutexMonitor(c_UpstreamHttpProtocolOptions_state_atomicMessageInfo_initMu);
	run mutexMonitor(c_CommonHttpProtocolOptions_state_atomicMessageInfo_initMu);
	run mutexMonitor(c_HttpProtocolOptions_state_atomicMessageInfo_initMu);
	run mutexMonitor(c_Http2ProtocolOptions_state_atomicMessageInfo_initMu);
	run mutexMonitor(c_DnsRefreshRate_state_atomicMessageInfo_initMu);
	run mutexMonitor(c_DnsFailureRefreshRate_state_atomicMessageInfo_initMu);
	run mutexMonitor(c_OutlierDetection_state_atomicMessageInfo_initMu);
	run mutexMonitor(c_CleanupInterval_state_atomicMessageInfo_initMu);
	run mutexMonitor(c_UpstreamBindConfig_state_atomicMessageInfo_initMu);
	run mutexMonitor(c_LbSubsetConfig_state_atomicMessageInfo_initMu);
	run mutexMonitor(c_CommonLbConfig_state_atomicMessageInfo_initMu);
	run mutexMonitor(c_TransportSocket_state_atomicMessageInfo_initMu);
	run mutexMonitor(c_Metadata_state_atomicMessageInfo_initMu);
	run mutexMonitor(c_UpstreamConnectionOptions_state_atomicMessageInfo_initMu);
	run mutexMonitor(c_LoadBalancingPolicy_state_atomicMessageInfo_initMu);
	run mutexMonitor(c_LrsServer_state_atomicMessageInfo_initMu);
	run mutexMonitor(c_UpstreamConfig_state_atomicMessageInfo_initMu);
	run mutexMonitor(c_TrackClusterStats_state_atomicMessageInfo_initMu);
	run mutexMonitor(c_PreconnectPolicy_state_atomicMessageInfo_initMu);
	run mutexMonitor(c_HiddenEnvoyDeprecatedTlsContext_state_atomicMessageInfo_initMu);
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

proctype receiver(chan c) {
c?0
}

