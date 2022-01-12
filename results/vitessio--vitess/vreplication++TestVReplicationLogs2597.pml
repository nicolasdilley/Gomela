// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/vttablet/tabletmanager/vreplication/vplayer_flaky_test.go#L2597
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestVReplicationLogs25970 = [1] of {int};
	run TestVReplicationLogs2597(child_TestVReplicationLogs25970);
	run receiver(child_TestVReplicationLogs25970)
stop_process:skip
}

proctype TestVReplicationLogs2597(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef vdbc_stats_VReplicationLagRates_mu;
	Mutexdef vdbc_stats_VReplicationLags_mu;
	Mutexdef vdbc_stats_QueryTimings_mu;
	Mutexdef vdbc_stats_PhaseTimings_mu;
	Mutexdef vdbc_stats_State_mu;
	Mutexdef vdbc_stats_History_mu;
	Mutexdef vdbc_stats_heartbeatMutex;
	Mutexdef vdbc_stats_lastPositionMutex;
	Mutexdef vdbc_stats_Rates_mu;
	Mutexdef vdbc_stats_Timings_mu;
	int var_expected = -2; // opt var_expected
	run mutexMonitor(vdbc_stats_Timings_mu);
	run mutexMonitor(vdbc_stats_Rates_mu);
	run mutexMonitor(vdbc_stats_lastPositionMutex);
	run mutexMonitor(vdbc_stats_heartbeatMutex);
	run mutexMonitor(vdbc_stats_History_mu);
	run mutexMonitor(vdbc_stats_State_mu);
	run mutexMonitor(vdbc_stats_PhaseTimings_mu);
	run mutexMonitor(vdbc_stats_QueryTimings_mu);
	run mutexMonitor(vdbc_stats_VReplicationLags_mu);
	run mutexMonitor(vdbc_stats_VReplicationLagRates_mu);
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

