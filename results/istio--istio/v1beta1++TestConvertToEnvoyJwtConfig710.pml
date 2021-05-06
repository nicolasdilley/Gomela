
// https://github.com/istio/istio/blob/master/pilot/pkg/security/authn/v1beta1/policy_applier_test.go#L710
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestConvertToEnvoyJwtConfig7100 = [1] of {int};
	run TestConvertToEnvoyJwtConfig710(child_TestConvertToEnvoyJwtConfig7100)
stop_process:skip
}

proctype TestConvertToEnvoyJwtConfig710(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef push_initializeMutex;
	Mutexdef push_networksMu;
	Mutexdef push_JwtKeyResolver_keyEntries_mu;
	Mutexdef push_proxyStatusMutex;
	Mutexdef ms_server_mu;
	Mutexdef ms_server_nextProtoOnce_m;
	Mutexdef ms_server_ErrorLog_mu;
	Mutexdef ms_server_TLSConfig_mutex;
	run mutexMonitor(ms_server_TLSConfig_mutex);
	run mutexMonitor(ms_server_ErrorLog_mu);
	run mutexMonitor(ms_server_nextProtoOnce_m);
	run mutexMonitor(ms_server_mu);
	run mutexMonitor(push_proxyStatusMutex);
	run mutexMonitor(push_JwtKeyResolver_keyEntries_mu);
	run mutexMonitor(push_networksMu);
	run mutexMonitor(push_initializeMutex);
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

