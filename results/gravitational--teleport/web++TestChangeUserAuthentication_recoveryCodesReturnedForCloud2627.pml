// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/gravitational/teleport/blob//lib/web/apiserver_test.go#L2627
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestChangeUserAuthentication_recoveryCodesReturnedForCloud26270 = [1] of {int};
	run TestChangeUserAuthentication_recoveryCodesReturnedForCloud2627(child_TestChangeUserAuthentication_recoveryCodesReturnedForCloud26270);
	run receiver(child_TestChangeUserAuthentication_recoveryCodesReturnedForCloud26270)
stop_process:skip
}

proctype TestChangeUserAuthentication_recoveryCodesReturnedForCloud2627(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef env_node_termHandlers_SessionRegistry_mu;
	Mutexdef env_node_dynamicLabels_mu;
	Mutexdef env_node_reg_mu;
	Mutexdef env_server_AuthServer_AuthServer_lock;
	run mutexMonitor(env_server_AuthServer_AuthServer_lock);
	run mutexMonitor(env_node_reg_mu);
	run mutexMonitor(env_node_dynamicLabels_mu);
	run mutexMonitor(env_node_termHandlers_SessionRegistry_mu);
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

