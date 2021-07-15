
// https://github.com/hashicorp/consul/blob/master/connect/resolver_test.go#L234
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestConsulResolverFromAddrFunc2340 = [1] of {int};
	run TestConsulResolverFromAddrFunc234(child_TestConsulResolverFromAddrFunc2340)
stop_process:skip
}

proctype TestConsulResolverFromAddrFunc234(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

