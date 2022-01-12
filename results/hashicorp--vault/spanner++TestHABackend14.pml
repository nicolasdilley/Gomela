// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/vault/blob//physical/spanner/spanner_ha_test.go#L14
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestHABackend140 = [1] of {int};
	run TestHABackend14(child_TestHABackend140);
	run receiver(child_TestHABackend140)
stop_process:skip
}

proctype TestHABackend14(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_testCleanup141 = [1] of {int};
	chan child_testCleanup143 = [1] of {int};
	chan child_testCleanup142 = [1] of {int};
	chan child_testCleanup140 = [1] of {int};
	Mutexdef client_logger_mu;
	Mutexdef client_idleSessions_mw_mu;
	Mutexdef client_idleSessions_hc_once_m;
	Wgdef client_idleSessions_hc_waitWorkers;
	Mutexdef client_idleSessions_hc_mu;
	Mutexdef client_idleSessions_sc_logger_mu;
	Mutexdef client_idleSessions_sc_mu;
	Mutexdef client_idleSessions_mu;
	Mutexdef client_sc_logger_mu;
	Mutexdef client_sc_mu;
	run mutexMonitor(client_sc_mu);
	run mutexMonitor(client_sc_logger_mu);
	run mutexMonitor(client_idleSessions_mu);
	run mutexMonitor(client_idleSessions_sc_mu);
	run mutexMonitor(client_idleSessions_sc_logger_mu);
	run mutexMonitor(client_idleSessions_hc_mu);
	run wgMonitor(client_idleSessions_hc_waitWorkers);
	run mutexMonitor(client_idleSessions_hc_once_m);
	run mutexMonitor(client_idleSessions_mw_mu);
	run mutexMonitor(client_logger_mu);
	run testCleanup14(client_idleSessions_hc_waitWorkers,client_idleSessions_hc_mu,client_idleSessions_hc_once_m,client_idleSessions_mu,client_idleSessions_mw_mu,client_idleSessions_sc_logger_mu,client_idleSessions_sc_mu,client_logger_mu,client_sc_logger_mu,client_sc_mu,child_testCleanup140);
	child_testCleanup140?0;
	run testCleanup14(client_idleSessions_hc_waitWorkers,client_idleSessions_hc_mu,client_idleSessions_hc_once_m,client_idleSessions_mu,client_idleSessions_mw_mu,client_idleSessions_sc_logger_mu,client_idleSessions_sc_mu,client_logger_mu,client_sc_logger_mu,client_sc_mu,child_testCleanup142);
	child_testCleanup142?0;
		defer2: skip;
	run testCleanup14(client_idleSessions_hc_waitWorkers,client_idleSessions_hc_mu,client_idleSessions_hc_once_m,client_idleSessions_mu,client_idleSessions_mw_mu,client_idleSessions_sc_logger_mu,client_idleSessions_sc_mu,client_logger_mu,client_sc_logger_mu,client_sc_mu,child_testCleanup143);
	child_testCleanup143?0;
		defer1: skip;
	run testCleanup14(client_idleSessions_hc_waitWorkers,client_idleSessions_hc_mu,client_idleSessions_hc_once_m,client_idleSessions_mu,client_idleSessions_mw_mu,client_idleSessions_sc_logger_mu,client_idleSessions_sc_mu,client_logger_mu,client_sc_logger_mu,client_sc_mu,child_testCleanup141);
	child_testCleanup141?0;
	stop_process: skip;
	child!0
}
proctype testCleanup14(Wgdef client_idleSessions_hc_waitWorkers;Mutexdef client_idleSessions_hc_mu;Mutexdef client_idleSessions_hc_once_m;Mutexdef client_idleSessions_mu;Mutexdef client_idleSessions_mw_mu;Mutexdef client_idleSessions_sc_logger_mu;Mutexdef client_idleSessions_sc_mu;Mutexdef client_logger_mu;Mutexdef client_sc_logger_mu;Mutexdef client_sc_mu;chan child) {
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
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

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

