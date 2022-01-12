// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/throttler/max_replication_lag_module_test.go#L111
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
	chan child_TestMaxReplicationLagModule_InitialStateAndWait1110 = [1] of {int};
	run TestMaxReplicationLagModule_InitialStateAndWait111(child_TestMaxReplicationLagModule_InitialStateAndWait1110);
	run receiver(child_TestMaxReplicationLagModule_InitialStateAndWait1110)
stop_process:skip
}

proctype TestMaxReplicationLagModule_InitialStateAndWait111(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_checkState860 = [1] of {int};
	Mutexdef tf_m_results_mu;
	Wgdef tf_m_wg;
	Mutexdef tf_m_mutableConfigMu;
	run mutexMonitor(tf_m_mutableConfigMu);
	run wgMonitor(tf_m_wg);
	run mutexMonitor(tf_m_results_mu);
	run checkState86(tf_m_wg,tf_m_mutableConfigMu,tf_m_results_mu,child_checkState860);
	child_checkState860?0;
	stop_process: skip;
	child!0
}
proctype checkState86(Wgdef tf_m_wg;Mutexdef tf_m_mutableConfigMu;Mutexdef tf_m_results_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_MaxRate1800 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run MaxRate180(tf_m_wg,tf_m_mutableConfigMu,tf_m_results_mu,child_MaxRate1800);
	child_MaxRate1800?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype MaxRate180(Wgdef m_wg;Mutexdef m_mutableConfigMu;Mutexdef m_results_mu;chan child) {
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

