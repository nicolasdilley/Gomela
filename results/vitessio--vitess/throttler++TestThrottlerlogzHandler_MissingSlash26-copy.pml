// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/throttler/throttlerlogz_test.go#L26
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
	chan child_TestThrottlerlogzHandler_MissingSlash260 = [1] of {int};
	run TestThrottlerlogzHandler_MissingSlash26(child_TestThrottlerlogzHandler_MissingSlash260);
	run receiver(child_TestThrottlerlogzHandler_MissingSlash260)
stop_process:skip
}

proctype TestThrottlerlogzHandler_MissingSlash26(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_throttlerlogzHandler1070 = [1] of {int};
	Mutexdef m_mu;
	run mutexMonitor(m_mu);
	run throttlerlogzHandler107(m_mu,child_throttlerlogzHandler1070);
	child_throttlerlogzHandler1070?0;
	stop_process: skip;
	child!0
}
proctype throttlerlogzHandler107(Mutexdef m_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_showThrottlerLog1270 = [1] of {int};
	

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
	run showThrottlerLog127(m_mu,child_showThrottlerLog1270);
	child_showThrottlerLog1270?0;
	stop_process: skip;
	child!0
}
proctype showThrottlerLog127(Mutexdef m_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Log2100 = [1] of {int};
	int var_results = -2; // opt var_results
	run Log210(m_mu,child_Log2100);
	child_Log2100?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype Log210(Mutexdef m_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Log3190 = [1] of {int};
	Mutexdef t_mu;
	Mutexdef t_maxReplicationLagModule_results_mu;
	Wgdef t_maxReplicationLagModule_wg;
	Mutexdef t_maxReplicationLagModule_mutableConfigMu;
	Mutexdef t_manager_mu;
	m_mu.Lock!false;
	run mutexMonitor(t_manager_mu);
	run mutexMonitor(t_maxReplicationLagModule_mutableConfigMu);
	run wgMonitor(t_maxReplicationLagModule_wg);
	run mutexMonitor(t_maxReplicationLagModule_results_mu);
	run mutexMonitor(t_mu);
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	run Log319(t_maxReplicationLagModule_wg,t_manager_mu,t_maxReplicationLagModule_mutableConfigMu,t_maxReplicationLagModule_results_mu,t_mu,child_Log3190);
	child_Log3190?0;
	goto defer1;
		defer1: skip;
	m_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Log319(Wgdef t_maxReplicationLagModule_wg;Mutexdef t_manager_mu;Mutexdef t_maxReplicationLagModule_mutableConfigMu;Mutexdef t_maxReplicationLagModule_results_mu;Mutexdef t_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_log7940 = [1] of {int};
	run log794(t_maxReplicationLagModule_wg,t_maxReplicationLagModule_mutableConfigMu,t_maxReplicationLagModule_results_mu,child_log7940);
	child_log7940?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype log794(Wgdef m_wg;Mutexdef m_mutableConfigMu;Mutexdef m_results_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_latestValues1510 = [1] of {int};
	run latestValues151(m_results_mu,child_latestValues1510);
	child_latestValues1510?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype latestValues151(Mutexdef rr_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_count = -2; // opt var_count
	rr_mu.Lock!false;
	goto defer1;
		defer1: skip;
	rr_mu.Unlock!false;
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

