// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/vault/blob/f8f289712a3d37115090591602a2b92503fb3a13/vault/external_tests/sealmigration/testshared.go#L739
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_runAutoseal7390 = [1] of {int};
	run runAutoseal739(child_runAutoseal7390);
	run receiver(child_runAutoseal7390)
stop_process:skip
}

proctype runAutoseal739(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef client_config_modifyLock;
	Mutexdef client_modifyLock;
	chan child_DeriveActiveCore2351 = [1] of {int};
	Mutexdef leaderCore_TLSConfig_mutex;
	Mutexdef leaderCore_Server_mu;
	Mutexdef leaderCore_ReloadFuncsLock;
	Mutexdef leaderCore_Client_modifyLock;
	Mutexdef leaderCore_CoreConfig_ReloadFuncsLock;
	chan child_WaitForNCoresUnsealed2690 = [1] of {int};
	Mutexdef cluster_base_ReloadFuncsLock;
	Mutexdef conf_ReloadFuncsLock;
	int var_cluster_Cores = -2; // opt var_cluster_Cores
	run mutexMonitor(conf_ReloadFuncsLock);
	run mutexMonitor(cluster_base_ReloadFuncsLock);
	run WaitForNCoresUnsealed269(cluster_base_ReloadFuncsLock,child_WaitForNCoresUnsealed2690);
	child_WaitForNCoresUnsealed2690?0;
	run mutexMonitor(leaderCore_CoreConfig_ReloadFuncsLock);
	run mutexMonitor(leaderCore_Client_modifyLock);
	run mutexMonitor(leaderCore_ReloadFuncsLock);
	run mutexMonitor(leaderCore_Server_mu);
	run mutexMonitor(leaderCore_TLSConfig_mutex);
	run DeriveActiveCore235(cluster_base_ReloadFuncsLock,child_DeriveActiveCore2351);
	child_DeriveActiveCore2351?0;
	run mutexMonitor(client_modifyLock);
	run mutexMonitor(client_config_modifyLock);
	stop_process: skip;
	child!0
}
proctype WaitForNCoresUnsealed269(Mutexdef cluster_base_ReloadFuncsLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_cluster_Cores = -2; // opt var_cluster_Cores
	stop_process: skip;
	child!0
}
proctype DeriveActiveCore235(Mutexdef cluster_base_ReloadFuncsLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_cluster_Cores = -2; // opt var_cluster_Cores
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

