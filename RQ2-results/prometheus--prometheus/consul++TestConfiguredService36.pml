#define not_found_237  -2

// https://github.com/prometheus/prometheus/blob/master/discovery/consul/consul_test.go#L36
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestConfiguredService360 = [1] of {int};
	run TestConfiguredService36(child_TestConfiguredService360)
stop_process:skip
}

proctype TestConfiguredService36(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_shouldWatch2361 = [1] of {int};
	chan child_shouldWatch2360 = [1] of {int};
	Mutexdef consulDiscovery_client_config_Transport_nextProtoOnce_m;
	Mutexdef consulDiscovery_client_config_Transport_TLSClientConfig_mutex;
	Mutexdef consulDiscovery_client_config_Transport_connsPerHostMu;
	Mutexdef consulDiscovery_client_config_Transport_altMu;
	Mutexdef consulDiscovery_client_config_Transport_reqMu;
	Mutexdef consulDiscovery_client_config_Transport_idleMu;
	run mutexMonitor(consulDiscovery_client_config_Transport_idleMu);
	run mutexMonitor(consulDiscovery_client_config_Transport_reqMu);
	run mutexMonitor(consulDiscovery_client_config_Transport_altMu);
	run mutexMonitor(consulDiscovery_client_config_Transport_connsPerHostMu);
	run mutexMonitor(consulDiscovery_client_config_Transport_TLSClientConfig_mutex);
	run mutexMonitor(consulDiscovery_client_config_Transport_nextProtoOnce_m);
	run shouldWatch236(consulDiscovery_client_config_Transport_idleMu,consulDiscovery_client_config_Transport_reqMu,consulDiscovery_client_config_Transport_altMu,consulDiscovery_client_config_Transport_connsPerHostMu,consulDiscovery_client_config_Transport_TLSClientConfig_mutex,consulDiscovery_client_config_Transport_nextProtoOnce_m,child_shouldWatch2360);
	child_shouldWatch2360?0;
	run shouldWatch236(consulDiscovery_client_config_Transport_idleMu,consulDiscovery_client_config_Transport_reqMu,consulDiscovery_client_config_Transport_altMu,consulDiscovery_client_config_Transport_connsPerHostMu,consulDiscovery_client_config_Transport_TLSClientConfig_mutex,consulDiscovery_client_config_Transport_nextProtoOnce_m,child_shouldWatch2361);
	child_shouldWatch2361?0;
	stop_process: skip;
	child!0
}
proctype shouldWatch236(Mutexdef d_client_config_Transport_idleMu;Mutexdef d_client_config_Transport_reqMu;Mutexdef d_client_config_Transport_altMu;Mutexdef d_client_config_Transport_connsPerHostMu;Mutexdef d_client_config_Transport_TLSClientConfig_mutex;Mutexdef d_client_config_Transport_nextProtoOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_shouldWatchFromTags2581 = [1] of {int};
	chan child_shouldWatchFromName2410 = [1] of {int};
	run shouldWatchFromName241(d_client_config_Transport_idleMu,d_client_config_Transport_reqMu,d_client_config_Transport_altMu,d_client_config_Transport_connsPerHostMu,d_client_config_Transport_TLSClientConfig_mutex,d_client_config_Transport_nextProtoOnce_m,child_shouldWatchFromName2410);
	child_shouldWatchFromName2410?0;
	run shouldWatchFromTags258(d_client_config_Transport_idleMu,d_client_config_Transport_reqMu,d_client_config_Transport_altMu,d_client_config_Transport_connsPerHostMu,d_client_config_Transport_TLSClientConfig_mutex,d_client_config_Transport_nextProtoOnce_m,not_found_237,child_shouldWatchFromTags2581);
	child_shouldWatchFromTags2581?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype shouldWatchFromName241(Mutexdef d_client_config_Transport_idleMu;Mutexdef d_client_config_Transport_reqMu;Mutexdef d_client_config_Transport_altMu;Mutexdef d_client_config_Transport_connsPerHostMu;Mutexdef d_client_config_Transport_TLSClientConfig_mutex;Mutexdef d_client_config_Transport_nextProtoOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype shouldWatchFromTags258(Mutexdef d_client_config_Transport_idleMu;Mutexdef d_client_config_Transport_reqMu;Mutexdef d_client_config_Transport_altMu;Mutexdef d_client_config_Transport_connsPerHostMu;Mutexdef d_client_config_Transport_TLSClientConfig_mutex;Mutexdef d_client_config_Transport_nextProtoOnce_m;int tags;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	tagOuter: skip;
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

