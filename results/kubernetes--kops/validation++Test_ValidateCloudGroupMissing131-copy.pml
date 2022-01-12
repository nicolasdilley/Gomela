// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kops/blob//pkg/validation/validate_cluster_test.go#L131
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_Test_ValidateCloudGroupMissing1310 = [1] of {int};
	run Test_ValidateCloudGroupMissing131(child_Test_ValidateCloudGroupMissing1310);
	run receiver(child_Test_ValidateCloudGroupMissing1310)
stop_process:skip
}

proctype Test_ValidateCloudGroupMissing131(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewClusterValidator1010 = [1] of {int};
	Mutexdef mockcloud_t_context_mu;
	Mutexdef mockcloud_t_context_match_mu;
	run mutexMonitor(mockcloud_t_context_match_mu);
	run mutexMonitor(mockcloud_t_context_mu);
	run NewClusterValidator101(mockcloud_t_context_match_mu,mockcloud_t_context_mu,child_NewClusterValidator1010);
	child_NewClusterValidator1010?0;
	stop_process: skip;
	child!0
}
proctype NewClusterValidator101(Mutexdef cloud_t_context_match_mu;Mutexdef cloud_t_context_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_instanceGroupList_Items = -2; // opt var_instanceGroupList_Items
	

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

