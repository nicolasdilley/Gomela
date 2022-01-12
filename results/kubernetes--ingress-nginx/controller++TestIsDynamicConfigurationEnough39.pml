// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/ingress-nginx/blob//internal/ingress/controller/nginx_test.go#L39
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestIsDynamicConfigurationEnough390 = [1] of {int};
	run TestIsDynamicConfigurationEnough39(child_TestIsDynamicConfigurationEnough390);
	run receiver(child_TestIsDynamicConfigurationEnough390)
stop_process:skip
}

proctype TestIsDynamicConfigurationEnough39(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_IsDynamicConfigurationEnough8195 = [1] of {int};
	chan child_IsDynamicConfigurationEnough8194 = [1] of {int};
	chan child_IsDynamicConfigurationEnough8193 = [1] of {int};
	chan child_IsDynamicConfigurationEnough8192 = [1] of {int};
	chan child_IsDynamicConfigurationEnough8191 = [1] of {int};
	chan child_IsDynamicConfigurationEnough8190 = [1] of {int};
	Mutexdef n_validationWebhookServer_mu;
	Mutexdef n_validationWebhookServer_nextProtoOnce_m;
	Mutexdef n_validationWebhookServer_ErrorLog_mu;
	Mutexdef n_validationWebhookServer_TLSConfig_mutex;
	Mutexdef n_stopLock;
	run mutexMonitor(n_stopLock);
	run mutexMonitor(n_validationWebhookServer_TLSConfig_mutex);
	run mutexMonitor(n_validationWebhookServer_ErrorLog_mu);
	run mutexMonitor(n_validationWebhookServer_nextProtoOnce_m);
	run mutexMonitor(n_validationWebhookServer_mu);
	run IsDynamicConfigurationEnough819(n_stopLock,n_validationWebhookServer_ErrorLog_mu,n_validationWebhookServer_mu,n_validationWebhookServer_nextProtoOnce_m,n_validationWebhookServer_TLSConfig_mutex,child_IsDynamicConfigurationEnough8190);
	child_IsDynamicConfigurationEnough8190?0;
	run IsDynamicConfigurationEnough819(n_stopLock,n_validationWebhookServer_ErrorLog_mu,n_validationWebhookServer_mu,n_validationWebhookServer_nextProtoOnce_m,n_validationWebhookServer_TLSConfig_mutex,child_IsDynamicConfigurationEnough8191);
	child_IsDynamicConfigurationEnough8191?0;
	run IsDynamicConfigurationEnough819(n_stopLock,n_validationWebhookServer_ErrorLog_mu,n_validationWebhookServer_mu,n_validationWebhookServer_nextProtoOnce_m,n_validationWebhookServer_TLSConfig_mutex,child_IsDynamicConfigurationEnough8192);
	child_IsDynamicConfigurationEnough8192?0;
	run IsDynamicConfigurationEnough819(n_stopLock,n_validationWebhookServer_ErrorLog_mu,n_validationWebhookServer_mu,n_validationWebhookServer_nextProtoOnce_m,n_validationWebhookServer_TLSConfig_mutex,child_IsDynamicConfigurationEnough8193);
	child_IsDynamicConfigurationEnough8193?0;
	run IsDynamicConfigurationEnough819(n_stopLock,n_validationWebhookServer_ErrorLog_mu,n_validationWebhookServer_mu,n_validationWebhookServer_nextProtoOnce_m,n_validationWebhookServer_TLSConfig_mutex,child_IsDynamicConfigurationEnough8194);
	child_IsDynamicConfigurationEnough8194?0;
	run IsDynamicConfigurationEnough819(n_stopLock,n_validationWebhookServer_ErrorLog_mu,n_validationWebhookServer_mu,n_validationWebhookServer_nextProtoOnce_m,n_validationWebhookServer_TLSConfig_mutex,child_IsDynamicConfigurationEnough8195);
	child_IsDynamicConfigurationEnough8195?0;
	stop_process: skip;
	child!0
}
proctype IsDynamicConfigurationEnough819(Mutexdef n_stopLock;Mutexdef n_validationWebhookServer_ErrorLog_mu;Mutexdef n_validationWebhookServer_mu;Mutexdef n_validationWebhookServer_nextProtoOnce_m;Mutexdef n_validationWebhookServer_TLSConfig_mutex;chan child) {
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

proctype receiver(chan c) {
c?0
}

