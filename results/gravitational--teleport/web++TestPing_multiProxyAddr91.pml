// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/gravitational/teleport/blob//lib/web/apiserver_ping_test.go#L91
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
	chan child_TestPing_multiProxyAddr910 = [1] of {int};
	run TestPing_multiProxyAddr91(child_TestPing_multiProxyAddr910);
	run receiver(child_TestPing_multiProxyAddr910)
stop_process:skip
}

proctype TestPing_multiProxyAddr91(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef proxy_web_mu;
	Wgdef proxy_web_wg;
	Mutexdef proxy_web_Config_mu;
	Mutexdef proxy_web_Config_nextProtoOnce_m;
	Mutexdef proxy_web_Config_ErrorLog_mu;
	Mutexdef proxy_web_Config_TLSConfig_mutex;
	Mutexdef proxy_web_TLS_mutex;
	Mutexdef proxy_handler_appHandler_cache_mu;
	Mutexdef proxy_handler_handler_auth_mu;
	Mutexdef proxy_proxy_termHandlers_SessionRegistry_mu;
	Mutexdef proxy_proxy_dynamicLabels_mu;
	Mutexdef proxy_proxy_reg_mu;
	Mutexdef proxy_node_termHandlers_SessionRegistry_mu;
	Mutexdef proxy_node_dynamicLabels_mu;
	Mutexdef proxy_node_reg_mu;
	Mutexdef proxy_auth_TLSServer_httpServer_mu;
	Mutexdef env_node_termHandlers_SessionRegistry_mu;
	Mutexdef env_node_dynamicLabels_mu;
	Mutexdef env_node_reg_mu;
	Mutexdef env_server_AuthServer_AuthServer_lock;
	int var_proxy_handler_handler_cfg_ProxyPublicAddrs = -2; // opt var_proxy_handler_handler_cfg_ProxyPublicAddrs
	run mutexMonitor(env_server_AuthServer_AuthServer_lock);
	run mutexMonitor(env_node_reg_mu);
	run mutexMonitor(env_node_dynamicLabels_mu);
	run mutexMonitor(env_node_termHandlers_SessionRegistry_mu);
	run mutexMonitor(proxy_auth_TLSServer_httpServer_mu);
	run mutexMonitor(proxy_node_reg_mu);
	run mutexMonitor(proxy_node_dynamicLabels_mu);
	run mutexMonitor(proxy_node_termHandlers_SessionRegistry_mu);
	run mutexMonitor(proxy_proxy_reg_mu);
	run mutexMonitor(proxy_proxy_dynamicLabels_mu);
	run mutexMonitor(proxy_proxy_termHandlers_SessionRegistry_mu);
	run mutexMonitor(proxy_handler_handler_auth_mu);
	run mutexMonitor(proxy_handler_appHandler_cache_mu);
	run mutexMonitor(proxy_web_TLS_mutex);
	run mutexMonitor(proxy_web_Config_TLSConfig_mutex);
	run mutexMonitor(proxy_web_Config_ErrorLog_mu);
	run mutexMonitor(proxy_web_Config_nextProtoOnce_m);
	run mutexMonitor(proxy_web_Config_mu);
	run wgMonitor(proxy_web_wg);
	run mutexMonitor(proxy_web_mu);
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

proctype receiver(chan c) {
c?0
}

