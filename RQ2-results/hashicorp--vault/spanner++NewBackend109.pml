
// https://github.com/hashicorp/vault/blob/master/physical/spanner/spanner.go#L109
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
	chan child_NewBackend1090 = [1] of {int};
	run NewBackend109(child_NewBackend1090)
stop_process:skip
}

proctype NewBackend109(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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
	Mutexdef haClient_qo_Options_state_atomicMessageInfo_initMu;
	Mutexdef haClient_logger_mu;
	Mutexdef haClient_idleSessions_mw_mu;
	Mutexdef haClient_idleSessions_hc_once_m;
	Wgdef haClient_idleSessions_hc_waitWorkers;
	Mutexdef haClient_idleSessions_hc_mu;
	Mutexdef haClient_idleSessions_sc_logger_mu;
	Mutexdef haClient_idleSessions_sc_mu;
	Mutexdef haClient_idleSessions_mu;
	Mutexdef haClient_sc_logger_mu;
	Mutexdef haClient_sc_mu;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(haClient_sc_mu);
	run mutexMonitor(haClient_sc_logger_mu);
	run mutexMonitor(haClient_idleSessions_mu);
	run mutexMonitor(haClient_idleSessions_sc_mu);
	run mutexMonitor(haClient_idleSessions_sc_logger_mu);
	run mutexMonitor(haClient_idleSessions_hc_mu);
	run wgMonitor(haClient_idleSessions_hc_waitWorkers);
	run mutexMonitor(haClient_idleSessions_hc_once_m);
	run mutexMonitor(haClient_idleSessions_mw_mu);
	run mutexMonitor(haClient_logger_mu);
	run mutexMonitor(haClient_qo_Options_state_atomicMessageInfo_initMu);
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

