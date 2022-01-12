// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/influxdata/telegraf/blob//plugins/inputs/consul/consul_test.go#L109
#define def_var_sampleChecks  -2 // opt checks line 125
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestGatherHealthCheckWithDelimitedTagsV21090 = [1] of {int};
	run TestGatherHealthCheckWithDelimitedTagsV2109(child_TestGatherHealthCheckWithDelimitedTagsV21090);
	run receiver(child_TestGatherHealthCheckWithDelimitedTagsV21090)
stop_process:skip
}

proctype TestGatherHealthCheckWithDelimitedTagsV2109(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GatherHealthCheck1250 = [1] of {int};
	int var_sampleChecks = def_var_sampleChecks;
	Mutexdef consul_client_config_Transport_connsPerHostMu;
	Mutexdef consul_client_config_Transport_altMu;
	Mutexdef consul_client_config_Transport_reqMu;
	Mutexdef consul_client_config_Transport_idleMu;
	Mutexdef consul_client_modifyLock;
	run mutexMonitor(consul_client_modifyLock);
	run mutexMonitor(consul_client_config_Transport_idleMu);
	run mutexMonitor(consul_client_config_Transport_reqMu);
	run mutexMonitor(consul_client_config_Transport_altMu);
	run mutexMonitor(consul_client_config_Transport_connsPerHostMu);
	run GatherHealthCheck125(consul_client_config_Transport_altMu,consul_client_config_Transport_connsPerHostMu,consul_client_config_Transport_idleMu,consul_client_config_Transport_reqMu,consul_client_modifyLock,var_sampleChecks,child_GatherHealthCheck1250);
	child_GatherHealthCheck1250?0;
	stop_process: skip;
	child!0
}
proctype GatherHealthCheck125(Mutexdef c_client_config_Transport_altMu;Mutexdef c_client_config_Transport_connsPerHostMu;Mutexdef c_client_config_Transport_idleMu;Mutexdef c_client_config_Transport_reqMu;Mutexdef c_client_modifyLock;int var_checks;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_check_ServiceTags = -2; // opt var_check_ServiceTags
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

