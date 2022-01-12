// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/istio/istio/blob//pilot/pkg/networking/core/v1alpha3/listener_builder_test.go#L154
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestVirtualInboundListenerBuilder1540 = [1] of {int};
	run TestVirtualInboundListenerBuilder154(child_TestVirtualInboundListenerBuilder1540);
	run receiver(child_TestVirtualInboundListenerBuilder1540)
stop_process:skip
}

proctype TestVirtualInboundListenerBuilder154(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef l_BindToPort_state_atomicMessageInfo_initMu;
	Mutexdef l_TcpBacklogSize_state_atomicMessageInfo_initMu;
	Mutexdef l_ConnectionBalanceConfig_state_atomicMessageInfo_initMu;
	Mutexdef l_ApiListener_state_atomicMessageInfo_initMu;
	Mutexdef l_UdpListenerConfig_state_atomicMessageInfo_initMu;
	Mutexdef l_TcpFastOpenQueueLength_state_atomicMessageInfo_initMu;
	Mutexdef l_Freebind_state_atomicMessageInfo_initMu;
	Mutexdef l_Transparent_state_atomicMessageInfo_initMu;
	Mutexdef l_ListenerFiltersTimeout_state_atomicMessageInfo_initMu;
	Mutexdef l_DeprecatedV1_state_atomicMessageInfo_initMu;
	Mutexdef l_Metadata_state_atomicMessageInfo_initMu;
	Mutexdef l_PerConnectionBufferLimitBytes_state_atomicMessageInfo_initMu;
	Mutexdef l_DefaultFilterChain_state_atomicMessageInfo_initMu;
	Mutexdef l_UseOriginalDst_state_atomicMessageInfo_initMu;
	Mutexdef l_Address_state_atomicMessageInfo_initMu;
	Mutexdef l_state_atomicMessageInfo_initMu;
	int var_byListenerName = -2; // opt var_byListenerName
	int var_l_FilterChains = -2; // opt var_l_FilterChains
	run mutexMonitor(l_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_Address_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_UseOriginalDst_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_DefaultFilterChain_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_PerConnectionBufferLimitBytes_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_Metadata_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_DeprecatedV1_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_ListenerFiltersTimeout_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_Transparent_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_Freebind_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_TcpFastOpenQueueLength_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_UdpListenerConfig_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_ApiListener_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_ConnectionBalanceConfig_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_TcpBacklogSize_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_BindToPort_state_atomicMessageInfo_initMu);
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

