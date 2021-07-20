// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/vault/blob/f8f289712a3d37115090591602a2b92503fb3a13/vault/external_tests/raft/raft_test.go#L72
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRaft_BoltDBMetrics720 = [1] of {int};
	run TestRaft_BoltDBMetrics72(child_TestRaft_BoltDBMetrics720);
	run receiver(child_TestRaft_BoltDBMetrics720)
stop_process:skip
}

proctype TestRaft_BoltDBMetrics72(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SysMetricsReq6710 = [1] of {int};
	Mutexdef leaderClient_config_modifyLock;
	Mutexdef leaderClient_modifyLock;
	Mutexdef cluster_base_ReloadFuncsLock;
	Mutexdef conf_ReloadFuncsLock;
	int var_data_Gaugesdata_Gauges = -2; // opt var_data_Gaugesdata_Gauges
	run mutexMonitor(conf_ReloadFuncsLock);
	run mutexMonitor(cluster_base_ReloadFuncsLock);
	run mutexMonitor(leaderClient_modifyLock);
	run mutexMonitor(leaderClient_config_modifyLock);
	run SysMetricsReq671(leaderClient_config_modifyLock,leaderClient_modifyLock,cluster_base_ReloadFuncsLock,child_SysMetricsReq6710);
	child_SysMetricsReq6710?0;
	stop_process: skip;
	child!0
}
proctype SysMetricsReq671(Mutexdef client_config_modifyLock;Mutexdef client_modifyLock;Mutexdef cluster_base_ReloadFuncsLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

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

proctype receiver(chan c) {
c?0
}

