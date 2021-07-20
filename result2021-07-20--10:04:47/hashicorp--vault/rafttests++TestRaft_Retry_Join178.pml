// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/vault/blob/f8f289712a3d37115090591602a2b92503fb3a13/vault/external_tests/raft/raft_test.go#L178
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRaft_Retry_Join1780 = [1] of {int};
	run TestRaft_Retry_Join178(child_TestRaft_Retry_Join1780);
	run receiver(child_TestRaft_Retry_Join1780)
stop_process:skip
}

proctype TestRaft_Retry_Join178(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef leaderCore_TLSConfig_mutex;
	Mutexdef leaderCore_Server_mu;
	Mutexdef leaderCore_ReloadFuncsLock;
	Mutexdef leaderCore_Client_modifyLock;
	Mutexdef leaderCore_CoreConfig_ReloadFuncsLock;
	Mutexdef cluster_base_ReloadFuncsLock;
	Mutexdef conf_ReloadFuncsLock;
	run mutexMonitor(conf_ReloadFuncsLock);
	run mutexMonitor(cluster_base_ReloadFuncsLock);
	run mutexMonitor(leaderCore_CoreConfig_ReloadFuncsLock);
	run mutexMonitor(leaderCore_Client_modifyLock);
	run mutexMonitor(leaderCore_ReloadFuncsLock);
	run mutexMonitor(leaderCore_Server_mu);
	run mutexMonitor(leaderCore_TLSConfig_mutex);
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

