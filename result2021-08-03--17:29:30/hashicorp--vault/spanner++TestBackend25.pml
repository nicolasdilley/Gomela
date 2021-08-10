// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/vault/blob/f8f289712a3d37115090591602a2b92503fb3a13/physical/spanner/spanner_test.go#L25
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBackend250 = [1] of {int};
	run TestBackend25(child_TestBackend250);
	run receiver(child_TestBackend250)
stop_process:skip
}

proctype TestBackend25(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_testCleanup141 = [1] of {int};
	chan child_testCleanup140 = [1] of {int};
	Mutexdef client_logger_mu;
	Mutexdef client_idleSessions_mu;
	Mutexdef client_sc_mu;
	run mutexMonitor(client_sc_mu);
	run mutexMonitor(client_idleSessions_mu);
	run mutexMonitor(client_logger_mu);
	run testCleanup14(client_idleSessions_mu,client_logger_mu,client_sc_mu,child_testCleanup140);
	child_testCleanup140?0;
		defer1: skip;
	run testCleanup14(client_idleSessions_mu,client_logger_mu,client_sc_mu,child_testCleanup141);
	child_testCleanup141?0;
	stop_process: skip;
	child!0
}
proctype testCleanup14(Mutexdef client_idleSessions_mu;Mutexdef client_logger_mu;Mutexdef client_sc_mu;chan child) {
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

