// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/istio/istio/blob/9a5df21188426a6a7dd7d7503e01330a79db8a48/security/pkg/stsservice/tokenmanager/sts_test.go#L68
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestStsCache680 = [1] of {int};
	run TestStsCache68(child_TestStsCache680);
	run receiver(child_TestStsCache680)
stop_process:skip
}

proctype TestStsCache68(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_tearDownTest2990 = [1] of {int};
	Mutexdef mockBackend_mutex;
	Mutexdef mockBackend_server_mu;
	Mutexdef stsServer_stsServer_mu;
	run mutexMonitor(stsServer_stsServer_mu);
	run mutexMonitor(mockBackend_server_mu);
	run mutexMonitor(mockBackend_mutex);
		defer1: skip;
	run tearDownTest299(stsServer_stsServer_mu,mockBackend_mutex,mockBackend_server_mu,child_tearDownTest2990);
	child_tearDownTest2990?0;
	stop_process: skip;
	child!0
}
proctype tearDownTest299(Mutexdef stsServer_stsServer_mu;Mutexdef backend_mutex;Mutexdef backend_server_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

