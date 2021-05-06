
// https://github.com/traefik/traefik/blob/master/pkg/anonymize/anonymize_config_test.go#L478
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestDo_staticConfiguration4780 = [1] of {int};
	run TestDo_staticConfiguration478(child_TestDo_staticConfiguration4780)
stop_process:skip
}

proctype TestDo_staticConfiguration478(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Do210 = [1] of {int};
	Mutexdef config_Providers_ConsulCatalog_client_config_Transport_nextProtoOnce_m;
	Mutexdef config_Providers_ConsulCatalog_client_config_Transport_TLSClientConfig_mutex;
	Mutexdef config_Providers_ConsulCatalog_client_config_Transport_connsPerHostMu;
	Mutexdef config_Providers_ConsulCatalog_client_config_Transport_altMu;
	Mutexdef config_Providers_ConsulCatalog_client_config_Transport_reqMu;
	Mutexdef config_Providers_ConsulCatalog_client_config_Transport_idleMu;
	Mutexdef config_Providers_KubernetesGateway_lastConfiguration_lock;
	Mutexdef config_Providers_KubernetesCRD_lastConfiguration_lock;
	Mutexdef config_Providers_KubernetesIngress_lastConfiguration_lock;
	run mutexMonitor(config_Providers_KubernetesIngress_lastConfiguration_lock);
	run mutexMonitor(config_Providers_KubernetesCRD_lastConfiguration_lock);
	run mutexMonitor(config_Providers_KubernetesGateway_lastConfiguration_lock);
	run mutexMonitor(config_Providers_ConsulCatalog_client_config_Transport_idleMu);
	run mutexMonitor(config_Providers_ConsulCatalog_client_config_Transport_reqMu);
	run mutexMonitor(config_Providers_ConsulCatalog_client_config_Transport_altMu);
	run mutexMonitor(config_Providers_ConsulCatalog_client_config_Transport_connsPerHostMu);
	run mutexMonitor(config_Providers_ConsulCatalog_client_config_Transport_TLSClientConfig_mutex);
	run mutexMonitor(config_Providers_ConsulCatalog_client_config_Transport_nextProtoOnce_m);
	run Do21(config_Providers_KubernetesIngress_lastConfiguration_lock,config_Providers_KubernetesCRD_lastConfiguration_lock,config_Providers_KubernetesGateway_lastConfiguration_lock,config_Providers_ConsulCatalog_client_config_Transport_idleMu,config_Providers_ConsulCatalog_client_config_Transport_reqMu,config_Providers_ConsulCatalog_client_config_Transport_altMu,config_Providers_ConsulCatalog_client_config_Transport_connsPerHostMu,config_Providers_ConsulCatalog_client_config_Transport_TLSClientConfig_mutex,config_Providers_ConsulCatalog_client_config_Transport_nextProtoOnce_m,child_Do210);
	child_Do210?0;
	stop_process: skip;
	child!0
}
proctype Do21(Mutexdef baseConfig_Providers_KubernetesIngress_lastConfiguration_lock;Mutexdef baseConfig_Providers_KubernetesCRD_lastConfiguration_lock;Mutexdef baseConfig_Providers_KubernetesGateway_lastConfiguration_lock;Mutexdef baseConfig_Providers_ConsulCatalog_client_config_Transport_idleMu;Mutexdef baseConfig_Providers_ConsulCatalog_client_config_Transport_reqMu;Mutexdef baseConfig_Providers_ConsulCatalog_client_config_Transport_altMu;Mutexdef baseConfig_Providers_ConsulCatalog_client_config_Transport_connsPerHostMu;Mutexdef baseConfig_Providers_ConsulCatalog_client_config_Transport_TLSClientConfig_mutex;Mutexdef baseConfig_Providers_ConsulCatalog_client_config_Transport_nextProtoOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

