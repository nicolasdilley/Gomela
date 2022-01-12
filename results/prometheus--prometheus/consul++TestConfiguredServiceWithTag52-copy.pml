// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/prometheus/prometheus/blob//discovery/consul/consul_test.go#L52
#define def_var_tags  -2 // opt tags line 258
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestConfiguredServiceWithTag520 = [1] of {int};
	run TestConfiguredServiceWithTag52(child_TestConfiguredServiceWithTag520);
	run receiver(child_TestConfiguredServiceWithTag520)
stop_process:skip
}

proctype TestConfiguredServiceWithTag52(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_shouldWatch2363 = [1] of {int};
	chan child_shouldWatch2362 = [1] of {int};
	chan child_shouldWatch2361 = [1] of {int};
	chan child_shouldWatch2360 = [1] of {int};
	Mutexdef consulDiscovery_client_config_Transport_connsPerHostMu;
	Mutexdef consulDiscovery_client_config_Transport_altMu;
	Mutexdef consulDiscovery_client_config_Transport_reqMu;
	Mutexdef consulDiscovery_client_config_Transport_idleMu;
	run mutexMonitor(consulDiscovery_client_config_Transport_idleMu);
	run mutexMonitor(consulDiscovery_client_config_Transport_reqMu);
	run mutexMonitor(consulDiscovery_client_config_Transport_altMu);
	run mutexMonitor(consulDiscovery_client_config_Transport_connsPerHostMu);
	run shouldWatch236(consulDiscovery_client_config_Transport_altMu,consulDiscovery_client_config_Transport_connsPerHostMu,consulDiscovery_client_config_Transport_idleMu,consulDiscovery_client_config_Transport_reqMu,child_shouldWatch2360);
	child_shouldWatch2360?0;
	run shouldWatch236(consulDiscovery_client_config_Transport_altMu,consulDiscovery_client_config_Transport_connsPerHostMu,consulDiscovery_client_config_Transport_idleMu,consulDiscovery_client_config_Transport_reqMu,child_shouldWatch2361);
	child_shouldWatch2361?0;
	run shouldWatch236(consulDiscovery_client_config_Transport_altMu,consulDiscovery_client_config_Transport_connsPerHostMu,consulDiscovery_client_config_Transport_idleMu,consulDiscovery_client_config_Transport_reqMu,child_shouldWatch2362);
	child_shouldWatch2362?0;
	run shouldWatch236(consulDiscovery_client_config_Transport_altMu,consulDiscovery_client_config_Transport_connsPerHostMu,consulDiscovery_client_config_Transport_idleMu,consulDiscovery_client_config_Transport_reqMu,child_shouldWatch2363);
	child_shouldWatch2363?0;
	stop_process: skip;
	child!0
}
proctype shouldWatch236(Mutexdef d_client_config_Transport_altMu;Mutexdef d_client_config_Transport_connsPerHostMu;Mutexdef d_client_config_Transport_idleMu;Mutexdef d_client_config_Transport_reqMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_shouldWatchFromTags2581 = [1] of {int};
	int var_tags = def_var_tags;
	chan child_shouldWatchFromName2410 = [1] of {int};
	run shouldWatchFromName241(d_client_config_Transport_altMu,d_client_config_Transport_connsPerHostMu,d_client_config_Transport_idleMu,d_client_config_Transport_reqMu,child_shouldWatchFromName2410);
	child_shouldWatchFromName2410?0;
	run shouldWatchFromTags258(d_client_config_Transport_altMu,d_client_config_Transport_connsPerHostMu,d_client_config_Transport_idleMu,d_client_config_Transport_reqMu,var_tags,child_shouldWatchFromTags2581);
	child_shouldWatchFromTags2581?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype shouldWatchFromName241(Mutexdef d_client_config_Transport_altMu;Mutexdef d_client_config_Transport_connsPerHostMu;Mutexdef d_client_config_Transport_idleMu;Mutexdef d_client_config_Transport_reqMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_d_watchedServices = -2; // opt var_d_watchedServices
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype shouldWatchFromTags258(Mutexdef d_client_config_Transport_altMu;Mutexdef d_client_config_Transport_connsPerHostMu;Mutexdef d_client_config_Transport_idleMu;Mutexdef d_client_config_Transport_reqMu;int var_tags;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_d_watchedTags = -2; // opt var_d_watchedTags
	

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

proctype receiver(chan c) {
c?0
}

