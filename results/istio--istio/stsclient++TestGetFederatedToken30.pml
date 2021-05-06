
// https://github.com/istio/istio/blob/master/security/pkg/nodeagent/plugin/providers/google/stsclient/stsclient_test.go#L30
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestGetFederatedToken300 = [1] of {int};
	run TestGetFederatedToken30(child_TestGetFederatedToken300)
stop_process:skip
}

proctype TestGetFederatedToken30(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef ms_mutex;
	Mutexdef ms_t_context_mu;
	Mutexdef ms_t_context_match_mu;
	Mutexdef ms_server_mu;
	Mutexdef ms_server_nextProtoOnce_m;
	Mutexdef ms_server_ErrorLog_mu;
	Mutexdef ms_server_TLSConfig_mutex;
	run mutexMonitor(ms_server_TLSConfig_mutex);
	run mutexMonitor(ms_server_ErrorLog_mu);
	run mutexMonitor(ms_server_nextProtoOnce_m);
	run mutexMonitor(ms_server_mu);
	run mutexMonitor(ms_t_context_match_mu);
	run mutexMonitor(ms_t_context_mu);
	run mutexMonitor(ms_mutex);
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

