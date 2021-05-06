
// https://github.com/istio/istio/blob/master/pkg/kube/inject/inject_test.go#L422
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_testInjectionTemplate4220 = [1] of {int};
	run testInjectionTemplate422(child_testInjectionTemplate4220)
stop_process:skip
}

proctype testInjectionTemplate422(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_runWebhook5550 = [1] of {int};
	Mutexdef webhook_env_TrustBundle_endpointMutex;
	Mutexdef webhook_env_TrustBundle_mutex;
	Mutexdef webhook_env_PushContext_initializeMutex;
	Mutexdef webhook_env_PushContext_networksMu;
	Mutexdef webhook_env_PushContext_JwtKeyResolver_keyEntries_mu;
	Mutexdef webhook_env_PushContext_proxyStatusMutex;
	Mutexdef webhook_mu;
	run mutexMonitor(webhook_mu);
	run mutexMonitor(webhook_env_PushContext_proxyStatusMutex);
	run mutexMonitor(webhook_env_PushContext_JwtKeyResolver_keyEntries_mu);
	run mutexMonitor(webhook_env_PushContext_networksMu);
	run mutexMonitor(webhook_env_PushContext_initializeMutex);
	run mutexMonitor(webhook_env_TrustBundle_mutex);
	run mutexMonitor(webhook_env_TrustBundle_endpointMutex);
	run runWebhook555(webhook_mu,webhook_env_PushContext_proxyStatusMutex,webhook_env_PushContext_JwtKeyResolver_keyEntries_mu,webhook_env_PushContext_networksMu,webhook_env_PushContext_initializeMutex,webhook_env_TrustBundle_mutex,webhook_env_TrustBundle_endpointMutex,child_runWebhook5550);
	child_runWebhook5550?0;
	stop_process: skip;
	child!0
}
proctype runWebhook555(Mutexdef webhook_mu;Mutexdef webhook_env_PushContext_proxyStatusMutex;Mutexdef webhook_env_PushContext_JwtKeyResolver_keyEntries_mu;Mutexdef webhook_env_PushContext_networksMu;Mutexdef webhook_env_PushContext_initializeMutex;Mutexdef webhook_env_TrustBundle_mutex;Mutexdef webhook_env_TrustBundle_endpointMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_inject7060 = [1] of {int};
	run inject706(webhook_mu,webhook_env_PushContext_proxyStatusMutex,webhook_env_PushContext_JwtKeyResolver_keyEntries_mu,webhook_env_PushContext_networksMu,webhook_env_PushContext_initializeMutex,webhook_env_TrustBundle_mutex,webhook_env_TrustBundle_endpointMutex,child_inject7060);
	child_inject7060?0;
	stop_process: skip;
	child!0
}
proctype inject706(Mutexdef wh_mu;Mutexdef wh_env_PushContext_proxyStatusMutex;Mutexdef wh_env_PushContext_JwtKeyResolver_keyEntries_mu;Mutexdef wh_env_PushContext_networksMu;Mutexdef wh_env_PushContext_initializeMutex;Mutexdef wh_env_TrustBundle_mutex;Mutexdef wh_env_TrustBundle_endpointMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	wh_mu.RLock!false;
	

	if
	:: true -> 
		wh_mu.RUnlock!false;
		goto stop_process
	:: true;
	fi;
	wh_mu.RUnlock!false;
	

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

