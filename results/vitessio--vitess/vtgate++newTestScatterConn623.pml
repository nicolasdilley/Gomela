// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/vtgate/legacy_scatter_conn_test.go#L623
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_newTestScatterConn6230 = [1] of {int};
	run newTestScatterConn623(child_newTestScatterConn6230);
	run receiver(child_newTestScatterConn6230)
stop_process:skip
}

proctype newTestScatterConn623(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewScatterConn991 = [1] of {int};
	chan child_NewTxConn450 = [1] of {int};
	Mutexdef gw_buffer_mu;
	Mutexdef gw_mu;
	Mutexdef gw_kev_subsMu;
	Mutexdef gw_kev_mu;
	run mutexMonitor(gw_kev_mu);
	run mutexMonitor(gw_kev_subsMu);
	run mutexMonitor(gw_mu);
	run mutexMonitor(gw_buffer_mu);
	run NewTxConn45(gw_buffer_mu,gw_kev_mu,gw_kev_subsMu,gw_mu,child_NewTxConn450);
	child_NewTxConn450?0;
	run NewScatterConn99(gw_buffer_mu,gw_kev_mu,gw_kev_subsMu,gw_mu,child_NewScatterConn991);
	child_NewScatterConn991?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype NewTxConn45(Mutexdef gw_buffer_mu;Mutexdef gw_kev_mu;Mutexdef gw_kev_subsMu;Mutexdef gw_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype NewScatterConn99(Mutexdef gw_buffer_mu;Mutexdef gw_kev_mu;Mutexdef gw_kev_subsMu;Mutexdef gw_mu;chan child) {
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

