
// https://github.com/hashicorp/vault/blob/master/physical/spanner/spanner_test.go#L25
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
	chan child_TestBackend250 = [1] of {int};
	run TestBackend25(child_TestBackend250)
stop_process:skip
}

proctype TestBackend25(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_testCleanup141 = [1] of {int};
	chan child_testCleanup140 = [1] of {int};
	Mutexdef client_qo_Options_state_atomicMessageInfo_initMu;
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
	run mutexMonitor(client_qo_Options_state_atomicMessageInfo_initMu);
	run testCleanup14(client_idleSessions_hc_waitWorkers,client_sc_mu,client_sc_logger_mu,client_idleSessions_mu,client_idleSessions_sc_mu,client_idleSessions_sc_logger_mu,client_idleSessions_hc_mu,client_idleSessions_hc_once_m,client_idleSessions_mw_mu,client_logger_mu,client_qo_Options_state_atomicMessageInfo_initMu,child_testCleanup140);
	child_testCleanup140?0;
	stop_process: skip;
		run testCleanup14(client_idleSessions_hc_waitWorkers,client_sc_mu,client_sc_logger_mu,client_idleSessions_mu,client_idleSessions_sc_mu,client_idleSessions_sc_logger_mu,client_idleSessions_hc_mu,client_idleSessions_hc_once_m,client_idleSessions_mw_mu,client_logger_mu,client_qo_Options_state_atomicMessageInfo_initMu,child_testCleanup141);
	child_testCleanup141?0;
	child!0
}
proctype testCleanup14(Wgdef client_idleSessions_hc_waitWorkers;Mutexdef client_sc_mu;Mutexdef client_sc_logger_mu;Mutexdef client_idleSessions_mu;Mutexdef client_idleSessions_sc_mu;Mutexdef client_idleSessions_sc_logger_mu;Mutexdef client_idleSessions_hc_mu;Mutexdef client_idleSessions_hc_once_m;Mutexdef client_idleSessions_mw_mu;Mutexdef client_logger_mu;Mutexdef client_qo_Options_state_atomicMessageInfo_initMu;chan child) {
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

