
// https://github.com/kubernetes/kubernetes/blob/master/test/integration/auth/svcaccttoken_test.go#L64
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
	chan child_TestServiceAccountTokenCreate640 = [1] of {int};
	run TestServiceAccountTokenCreate64(child_TestServiceAccountTokenCreate640)
stop_process:skip
}

proctype TestServiceAccountTokenCreate64(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef __mu;
	Wgdef __wg;
	Mutexdef __Config_mu;
	Mutexdef __Config_nextProtoOnce_m;
	Mutexdef __Config_ErrorLog_mu;
	Mutexdef __Config_TLSConfig_mutex;
	Mutexdef __TLS_mutex;
	Mutexdef master_GenericAPIServer_HandlerChainWaitGroup_mu;
	Wgdef master_GenericAPIServer_HandlerChainWaitGroup_wg;
	Mutexdef master_GenericAPIServer_readyzLock;
	Mutexdef master_GenericAPIServer_livezLock;
	Mutexdef master_GenericAPIServer_healthzLock;
	Mutexdef master_GenericAPIServer_preShutdownHookLock;
	Mutexdef master_GenericAPIServer_postStartHookLock;
	Mutexdef master_GenericAPIServer_OpenAPIVersionedService_rwMutex;
	Mutexdef master_GenericAPIServer_Handler_NonGoRestfulMux_lock;
	Mutexdef master_GenericAPIServer_Handler_GoRestfulContainer_ServeMux_mu;
	Mutexdef master_GenericAPIServer_Handler_GoRestfulContainer_webServicesLock;
	Mutexdef masterConfig_GenericConfig_HandlerChainWaitGroup_mu;
	Wgdef masterConfig_GenericConfig_HandlerChainWaitGroup_wg;
	run wgMonitor(masterConfig_GenericConfig_HandlerChainWaitGroup_wg);
	run mutexMonitor(masterConfig_GenericConfig_HandlerChainWaitGroup_mu);
	run mutexMonitor(master_GenericAPIServer_Handler_GoRestfulContainer_webServicesLock);
	run mutexMonitor(master_GenericAPIServer_Handler_GoRestfulContainer_ServeMux_mu);
	run mutexMonitor(master_GenericAPIServer_Handler_NonGoRestfulMux_lock);
	run mutexMonitor(master_GenericAPIServer_OpenAPIVersionedService_rwMutex);
	run mutexMonitor(master_GenericAPIServer_postStartHookLock);
	run mutexMonitor(master_GenericAPIServer_preShutdownHookLock);
	run mutexMonitor(master_GenericAPIServer_healthzLock);
	run mutexMonitor(master_GenericAPIServer_livezLock);
	run mutexMonitor(master_GenericAPIServer_readyzLock);
	run wgMonitor(master_GenericAPIServer_HandlerChainWaitGroup_wg);
	run mutexMonitor(master_GenericAPIServer_HandlerChainWaitGroup_mu);
	run mutexMonitor(__TLS_mutex);
	run mutexMonitor(__Config_TLSConfig_mutex);
	run mutexMonitor(__Config_ErrorLog_mu);
	run mutexMonitor(__Config_nextProtoOnce_m);
	run mutexMonitor(__Config_mu);
	run wgMonitor(__wg);
	run mutexMonitor(__mu);
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

