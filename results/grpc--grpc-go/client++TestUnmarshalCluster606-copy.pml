// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/grpc/grpc-go/blob//xds/internal/client/cds_test.go#L606
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestUnmarshalCluster6060 = [1] of {int};
	run TestUnmarshalCluster606(child_TestUnmarshalCluster6060);
	run receiver(child_TestUnmarshalCluster6060)
stop_process:skip
}

proctype TestUnmarshalCluster606(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef v3ClusterAny_state_atomicMessageInfo_initMu;
	Mutexdef v3Cluster_HiddenEnvoyDeprecatedTlsContext_state_atomicMessageInfo_initMu;
	Mutexdef v3Cluster_PreconnectPolicy_state_atomicMessageInfo_initMu;
	Mutexdef v3Cluster_TrackClusterStats_state_atomicMessageInfo_initMu;
	Mutexdef v3Cluster_UpstreamConfig_state_atomicMessageInfo_initMu;
	Mutexdef v3Cluster_LrsServer_state_atomicMessageInfo_initMu;
	Mutexdef v3Cluster_LoadBalancingPolicy_state_atomicMessageInfo_initMu;
	Mutexdef v3Cluster_UpstreamConnectionOptions_state_atomicMessageInfo_initMu;
	Mutexdef v3Cluster_Metadata_state_atomicMessageInfo_initMu;
	Mutexdef v3Cluster_TransportSocket_state_atomicMessageInfo_initMu;
	Mutexdef v3Cluster_CommonLbConfig_state_atomicMessageInfo_initMu;
	Mutexdef v3Cluster_LbSubsetConfig_state_atomicMessageInfo_initMu;
	Mutexdef v3Cluster_UpstreamBindConfig_state_atomicMessageInfo_initMu;
	Mutexdef v3Cluster_CleanupInterval_state_atomicMessageInfo_initMu;
	Mutexdef v3Cluster_OutlierDetection_state_atomicMessageInfo_initMu;
	Mutexdef v3Cluster_DnsFailureRefreshRate_state_atomicMessageInfo_initMu;
	Mutexdef v3Cluster_DnsRefreshRate_state_atomicMessageInfo_initMu;
	Mutexdef v3Cluster_Http2ProtocolOptions_state_atomicMessageInfo_initMu;
	Mutexdef v3Cluster_HttpProtocolOptions_state_atomicMessageInfo_initMu;
	Mutexdef v3Cluster_CommonHttpProtocolOptions_state_atomicMessageInfo_initMu;
	Mutexdef v3Cluster_UpstreamHttpProtocolOptions_state_atomicMessageInfo_initMu;
	Mutexdef v3Cluster_CircuitBreakers_state_atomicMessageInfo_initMu;
	Mutexdef v3Cluster_MaxRequestsPerConnection_state_atomicMessageInfo_initMu;
	Mutexdef v3Cluster_LoadAssignment_state_atomicMessageInfo_initMu;
	Mutexdef v3Cluster_PerConnectionBufferLimitBytes_state_atomicMessageInfo_initMu;
	Mutexdef v3Cluster_ConnectTimeout_state_atomicMessageInfo_initMu;
	Mutexdef v3Cluster_EdsClusterConfig_state_atomicMessageInfo_initMu;
	Mutexdef v3Cluster_state_atomicMessageInfo_initMu;
	Mutexdef v2ClusterAny_state_atomicMessageInfo_initMu;
	Mutexdef v2Cluster_LrsServer_state_atomicMessageInfo_initMu;
	Mutexdef v2Cluster_LoadBalancingPolicy_state_atomicMessageInfo_initMu;
	Mutexdef v2Cluster_UpstreamConnectionOptions_state_atomicMessageInfo_initMu;
	Mutexdef v2Cluster_Metadata_state_atomicMessageInfo_initMu;
	Mutexdef v2Cluster_TransportSocket_state_atomicMessageInfo_initMu;
	Mutexdef v2Cluster_CommonLbConfig_state_atomicMessageInfo_initMu;
	Mutexdef v2Cluster_LbSubsetConfig_state_atomicMessageInfo_initMu;
	Mutexdef v2Cluster_UpstreamBindConfig_state_atomicMessageInfo_initMu;
	Mutexdef v2Cluster_CleanupInterval_state_atomicMessageInfo_initMu;
	Mutexdef v2Cluster_OutlierDetection_state_atomicMessageInfo_initMu;
	Mutexdef v2Cluster_DnsFailureRefreshRate_state_atomicMessageInfo_initMu;
	Mutexdef v2Cluster_DnsRefreshRate_state_atomicMessageInfo_initMu;
	Mutexdef v2Cluster_Http2ProtocolOptions_state_atomicMessageInfo_initMu;
	Mutexdef v2Cluster_HttpProtocolOptions_state_atomicMessageInfo_initMu;
	Mutexdef v2Cluster_CommonHttpProtocolOptions_state_atomicMessageInfo_initMu;
	Mutexdef v2Cluster_UpstreamHttpProtocolOptions_state_atomicMessageInfo_initMu;
	Mutexdef v2Cluster_TlsContext_state_atomicMessageInfo_initMu;
	Mutexdef v2Cluster_CircuitBreakers_state_atomicMessageInfo_initMu;
	Mutexdef v2Cluster_MaxRequestsPerConnection_state_atomicMessageInfo_initMu;
	Mutexdef v2Cluster_LoadAssignment_state_atomicMessageInfo_initMu;
	Mutexdef v2Cluster_PerConnectionBufferLimitBytes_state_atomicMessageInfo_initMu;
	Mutexdef v2Cluster_ConnectTimeout_state_atomicMessageInfo_initMu;
	Mutexdef v2Cluster_EdsClusterConfig_state_atomicMessageInfo_initMu;
	Mutexdef v2Cluster_state_atomicMessageInfo_initMu;
	int var_tests = -2; // opt var_tests
	run mutexMonitor(v2Cluster_state_atomicMessageInfo_initMu);
	run mutexMonitor(v2Cluster_EdsClusterConfig_state_atomicMessageInfo_initMu);
	run mutexMonitor(v2Cluster_ConnectTimeout_state_atomicMessageInfo_initMu);
	run mutexMonitor(v2Cluster_PerConnectionBufferLimitBytes_state_atomicMessageInfo_initMu);
	run mutexMonitor(v2Cluster_LoadAssignment_state_atomicMessageInfo_initMu);
	run mutexMonitor(v2Cluster_MaxRequestsPerConnection_state_atomicMessageInfo_initMu);
	run mutexMonitor(v2Cluster_CircuitBreakers_state_atomicMessageInfo_initMu);
	run mutexMonitor(v2Cluster_TlsContext_state_atomicMessageInfo_initMu);
	run mutexMonitor(v2Cluster_UpstreamHttpProtocolOptions_state_atomicMessageInfo_initMu);
	run mutexMonitor(v2Cluster_CommonHttpProtocolOptions_state_atomicMessageInfo_initMu);
	run mutexMonitor(v2Cluster_HttpProtocolOptions_state_atomicMessageInfo_initMu);
	run mutexMonitor(v2Cluster_Http2ProtocolOptions_state_atomicMessageInfo_initMu);
	run mutexMonitor(v2Cluster_DnsRefreshRate_state_atomicMessageInfo_initMu);
	run mutexMonitor(v2Cluster_DnsFailureRefreshRate_state_atomicMessageInfo_initMu);
	run mutexMonitor(v2Cluster_OutlierDetection_state_atomicMessageInfo_initMu);
	run mutexMonitor(v2Cluster_CleanupInterval_state_atomicMessageInfo_initMu);
	run mutexMonitor(v2Cluster_UpstreamBindConfig_state_atomicMessageInfo_initMu);
	run mutexMonitor(v2Cluster_LbSubsetConfig_state_atomicMessageInfo_initMu);
	run mutexMonitor(v2Cluster_CommonLbConfig_state_atomicMessageInfo_initMu);
	run mutexMonitor(v2Cluster_TransportSocket_state_atomicMessageInfo_initMu);
	run mutexMonitor(v2Cluster_Metadata_state_atomicMessageInfo_initMu);
	run mutexMonitor(v2Cluster_UpstreamConnectionOptions_state_atomicMessageInfo_initMu);
	run mutexMonitor(v2Cluster_LoadBalancingPolicy_state_atomicMessageInfo_initMu);
	run mutexMonitor(v2Cluster_LrsServer_state_atomicMessageInfo_initMu);
	run mutexMonitor(v2ClusterAny_state_atomicMessageInfo_initMu);
	run mutexMonitor(v3Cluster_state_atomicMessageInfo_initMu);
	run mutexMonitor(v3Cluster_EdsClusterConfig_state_atomicMessageInfo_initMu);
	run mutexMonitor(v3Cluster_ConnectTimeout_state_atomicMessageInfo_initMu);
	run mutexMonitor(v3Cluster_PerConnectionBufferLimitBytes_state_atomicMessageInfo_initMu);
	run mutexMonitor(v3Cluster_LoadAssignment_state_atomicMessageInfo_initMu);
	run mutexMonitor(v3Cluster_MaxRequestsPerConnection_state_atomicMessageInfo_initMu);
	run mutexMonitor(v3Cluster_CircuitBreakers_state_atomicMessageInfo_initMu);
	run mutexMonitor(v3Cluster_UpstreamHttpProtocolOptions_state_atomicMessageInfo_initMu);
	run mutexMonitor(v3Cluster_CommonHttpProtocolOptions_state_atomicMessageInfo_initMu);
	run mutexMonitor(v3Cluster_HttpProtocolOptions_state_atomicMessageInfo_initMu);
	run mutexMonitor(v3Cluster_Http2ProtocolOptions_state_atomicMessageInfo_initMu);
	run mutexMonitor(v3Cluster_DnsRefreshRate_state_atomicMessageInfo_initMu);
	run mutexMonitor(v3Cluster_DnsFailureRefreshRate_state_atomicMessageInfo_initMu);
	run mutexMonitor(v3Cluster_OutlierDetection_state_atomicMessageInfo_initMu);
	run mutexMonitor(v3Cluster_CleanupInterval_state_atomicMessageInfo_initMu);
	run mutexMonitor(v3Cluster_UpstreamBindConfig_state_atomicMessageInfo_initMu);
	run mutexMonitor(v3Cluster_LbSubsetConfig_state_atomicMessageInfo_initMu);
	run mutexMonitor(v3Cluster_CommonLbConfig_state_atomicMessageInfo_initMu);
	run mutexMonitor(v3Cluster_TransportSocket_state_atomicMessageInfo_initMu);
	run mutexMonitor(v3Cluster_Metadata_state_atomicMessageInfo_initMu);
	run mutexMonitor(v3Cluster_UpstreamConnectionOptions_state_atomicMessageInfo_initMu);
	run mutexMonitor(v3Cluster_LoadBalancingPolicy_state_atomicMessageInfo_initMu);
	run mutexMonitor(v3Cluster_LrsServer_state_atomicMessageInfo_initMu);
	run mutexMonitor(v3Cluster_UpstreamConfig_state_atomicMessageInfo_initMu);
	run mutexMonitor(v3Cluster_TrackClusterStats_state_atomicMessageInfo_initMu);
	run mutexMonitor(v3Cluster_PreconnectPolicy_state_atomicMessageInfo_initMu);
	run mutexMonitor(v3Cluster_HiddenEnvoyDeprecatedTlsContext_state_atomicMessageInfo_initMu);
	run mutexMonitor(v3ClusterAny_state_atomicMessageInfo_initMu);
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

