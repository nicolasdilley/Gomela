
// https://github.com/traefik/traefik/blob/master/pkg/provider/consulcatalog/consul_catalog.go#L297
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_createClient2970 = [1] of {int};
	run createClient297(child_createClient2970)
stop_process:skip
}

proctype createClient297(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef config_Transport_nextProtoOnce_m;
	Mutexdef config_Transport_TLSClientConfig_mutex;
	Mutexdef config_Transport_connsPerHostMu;
	Mutexdef config_Transport_altMu;
	Mutexdef config_Transport_reqMu;
	Mutexdef config_Transport_idleMu;
	run mutexMonitor(config_Transport_idleMu);
	run mutexMonitor(config_Transport_reqMu);
	run mutexMonitor(config_Transport_altMu);
	run mutexMonitor(config_Transport_connsPerHostMu);
	run mutexMonitor(config_Transport_TLSClientConfig_mutex);
	run mutexMonitor(config_Transport_nextProtoOnce_m);
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

