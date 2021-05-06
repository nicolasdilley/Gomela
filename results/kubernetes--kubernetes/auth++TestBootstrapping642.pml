
// https://github.com/kubernetes/kubernetes/blob/master/test/integration/auth/rbac_test.go#L642
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
	chan child_TestBootstrapping6420 = [1] of {int};
	run TestBootstrapping642(child_TestBootstrapping6420)
stop_process:skip
}

proctype TestBootstrapping642(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef s_mu;
	Wgdef s_wg;
	Mutexdef s_Config_mu;
	Mutexdef s_Config_nextProtoOnce_m;
	Mutexdef s_Config_ErrorLog_mu;
	Mutexdef s_Config_TLSConfig_mutex;
	Mutexdef s_TLS_mutex;
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
	chan child_newRBACAuthorizer920 = [1] of {int};
	Mutexdef masterConfig_GenericConfig_HandlerChainWaitGroup_mu;
	Wgdef masterConfig_GenericConfig_HandlerChainWaitGroup_wg;
	run wgMonitor(masterConfig_GenericConfig_HandlerChainWaitGroup_wg);
	run mutexMonitor(masterConfig_GenericConfig_HandlerChainWaitGroup_mu);
	run newRBACAuthorizer92(masterConfig_GenericConfig_HandlerChainWaitGroup_wg,masterConfig_GenericConfig_HandlerChainWaitGroup_mu,child_newRBACAuthorizer920);
	child_newRBACAuthorizer920?0;
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
	run mutexMonitor(s_TLS_mutex);
	run mutexMonitor(s_Config_TLSConfig_mutex);
	run mutexMonitor(s_Config_ErrorLog_mu);
	run mutexMonitor(s_Config_nextProtoOnce_m);
	run mutexMonitor(s_Config_mu);
	run wgMonitor(s_wg);
	run mutexMonitor(s_mu);
	stop_process: skip;
	child!0
}
proctype newRBACAuthorizer92(Wgdef config_GenericConfig_HandlerChainWaitGroup_wg;Mutexdef config_GenericConfig_HandlerChainWaitGroup_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef optsGetter_config_GenericConfig_HandlerChainWaitGroup_mu;
	Wgdef optsGetter_config_GenericConfig_HandlerChainWaitGroup_wg;
	run wgMonitor(optsGetter_config_GenericConfig_HandlerChainWaitGroup_wg);
	run mutexMonitor(optsGetter_config_GenericConfig_HandlerChainWaitGroup_mu);
	goto stop_process;
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

