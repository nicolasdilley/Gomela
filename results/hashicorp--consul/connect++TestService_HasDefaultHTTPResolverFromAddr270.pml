
// https://github.com/hashicorp/consul/blob/master/connect/service_test.go#L270
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestService_HasDefaultHTTPResolverFromAddr2700 = [1] of {int};
	run TestService_HasDefaultHTTPResolverFromAddr270(child_TestService_HasDefaultHTTPResolverFromAddr2700)
stop_process:skip
}

proctype TestService_HasDefaultHTTPResolverFromAddr270(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef expected_Client_config_Transport_nextProtoOnce_m;
	Mutexdef expected_Client_config_Transport_TLSClientConfig_mutex;
	Mutexdef expected_Client_config_Transport_connsPerHostMu;
	Mutexdef expected_Client_config_Transport_altMu;
	Mutexdef expected_Client_config_Transport_reqMu;
	Mutexdef expected_Client_config_Transport_idleMu;
	Mutexdef expected_Client_modifyLock;
	chan child_NewService1190 = [1] of {int};
	Mutexdef s_leafWatch_stopLock;
	Mutexdef s_leafWatch_client_config_Transport_nextProtoOnce_m;
	Mutexdef s_leafWatch_client_config_Transport_TLSClientConfig_mutex;
	Mutexdef s_leafWatch_client_config_Transport_connsPerHostMu;
	Mutexdef s_leafWatch_client_config_Transport_altMu;
	Mutexdef s_leafWatch_client_config_Transport_reqMu;
	Mutexdef s_leafWatch_client_config_Transport_idleMu;
	Mutexdef s_leafWatch_client_modifyLock;
	Mutexdef s_rootsWatch_stopLock;
	Mutexdef s_rootsWatch_client_config_Transport_nextProtoOnce_m;
	Mutexdef s_rootsWatch_client_config_Transport_TLSClientConfig_mutex;
	Mutexdef s_rootsWatch_client_config_Transport_connsPerHostMu;
	Mutexdef s_rootsWatch_client_config_Transport_altMu;
	Mutexdef s_rootsWatch_client_config_Transport_reqMu;
	Mutexdef s_rootsWatch_client_config_Transport_idleMu;
	Mutexdef s_rootsWatch_client_modifyLock;
	Mutexdef s_tlsCfg_base_mutex;
	Mutexdef s_client_config_Transport_nextProtoOnce_m;
	Mutexdef s_client_config_Transport_TLSClientConfig_mutex;
	Mutexdef s_client_config_Transport_connsPerHostMu;
	Mutexdef s_client_config_Transport_altMu;
	Mutexdef s_client_config_Transport_reqMu;
	Mutexdef s_client_config_Transport_idleMu;
	Mutexdef s_client_modifyLock;
	Mutexdef client_config_Transport_nextProtoOnce_m;
	Mutexdef client_config_Transport_TLSClientConfig_mutex;
	Mutexdef client_config_Transport_connsPerHostMu;
	Mutexdef client_config_Transport_altMu;
	Mutexdef client_config_Transport_reqMu;
	Mutexdef client_config_Transport_idleMu;
	Mutexdef client_modifyLock;
	run mutexMonitor(client_modifyLock);
	run mutexMonitor(client_config_Transport_idleMu);
	run mutexMonitor(client_config_Transport_reqMu);
	run mutexMonitor(client_config_Transport_altMu);
	run mutexMonitor(client_config_Transport_connsPerHostMu);
	run mutexMonitor(client_config_Transport_TLSClientConfig_mutex);
	run mutexMonitor(client_config_Transport_nextProtoOnce_m);
	run mutexMonitor(s_client_modifyLock);
	run mutexMonitor(s_client_config_Transport_idleMu);
	run mutexMonitor(s_client_config_Transport_reqMu);
	run mutexMonitor(s_client_config_Transport_altMu);
	run mutexMonitor(s_client_config_Transport_connsPerHostMu);
	run mutexMonitor(s_client_config_Transport_TLSClientConfig_mutex);
	run mutexMonitor(s_client_config_Transport_nextProtoOnce_m);
	run mutexMonitor(s_tlsCfg_base_mutex);
	run mutexMonitor(s_rootsWatch_client_modifyLock);
	run mutexMonitor(s_rootsWatch_client_config_Transport_idleMu);
	run mutexMonitor(s_rootsWatch_client_config_Transport_reqMu);
	run mutexMonitor(s_rootsWatch_client_config_Transport_altMu);
	run mutexMonitor(s_rootsWatch_client_config_Transport_connsPerHostMu);
	run mutexMonitor(s_rootsWatch_client_config_Transport_TLSClientConfig_mutex);
	run mutexMonitor(s_rootsWatch_client_config_Transport_nextProtoOnce_m);
	run mutexMonitor(s_rootsWatch_stopLock);
	run mutexMonitor(s_leafWatch_client_modifyLock);
	run mutexMonitor(s_leafWatch_client_config_Transport_idleMu);
	run mutexMonitor(s_leafWatch_client_config_Transport_reqMu);
	run mutexMonitor(s_leafWatch_client_config_Transport_altMu);
	run mutexMonitor(s_leafWatch_client_config_Transport_connsPerHostMu);
	run mutexMonitor(s_leafWatch_client_config_Transport_TLSClientConfig_mutex);
	run mutexMonitor(s_leafWatch_client_config_Transport_nextProtoOnce_m);
	run mutexMonitor(s_leafWatch_stopLock);
	run NewService119(client_modifyLock,client_config_Transport_idleMu,client_config_Transport_reqMu,client_config_Transport_altMu,client_config_Transport_connsPerHostMu,client_config_Transport_TLSClientConfig_mutex,client_config_Transport_nextProtoOnce_m,child_NewService1190);
	child_NewService1190?0;
	run mutexMonitor(expected_Client_modifyLock);
	run mutexMonitor(expected_Client_config_Transport_idleMu);
	run mutexMonitor(expected_Client_config_Transport_reqMu);
	run mutexMonitor(expected_Client_config_Transport_altMu);
	run mutexMonitor(expected_Client_config_Transport_connsPerHostMu);
	run mutexMonitor(expected_Client_config_Transport_TLSClientConfig_mutex);
	run mutexMonitor(expected_Client_config_Transport_nextProtoOnce_m);
	stop_process: skip;
	child!0
}
proctype NewService119(Mutexdef client_modifyLock;Mutexdef client_config_Transport_idleMu;Mutexdef client_config_Transport_reqMu;Mutexdef client_config_Transport_altMu;Mutexdef client_config_Transport_connsPerHostMu;Mutexdef client_config_Transport_TLSClientConfig_mutex;Mutexdef client_config_Transport_nextProtoOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

