// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/GoogleContainerTools/skaffold/blob//integration/build_cluster_test.go#L36
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBuildKanikoInsecureRegistry360 = [1] of {int};
	run TestBuildKanikoInsecureRegistry36(child_TestBuildKanikoInsecureRegistry360);
	run receiver(child_TestBuildKanikoInsecureRegistry360)
stop_process:skip
}

proctype TestBuildKanikoInsecureRegistry36(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ExternalIP3870 = [1] of {int};
	Mutexdef client_t_context_mu;
	Mutexdef client_t_context_match_mu;
	run mutexMonitor(client_t_context_match_mu);
	run mutexMonitor(client_t_context_mu);
	run ExternalIP387(client_t_context_match_mu,client_t_context_mu,child_ExternalIP3870);
	child_ExternalIP3870?0;
	stop_process: skip;
	child!0
}
proctype ExternalIP387(Mutexdef k_t_context_match_mu;Mutexdef k_t_context_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

