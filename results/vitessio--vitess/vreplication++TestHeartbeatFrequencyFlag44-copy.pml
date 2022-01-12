// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/vttablet/tabletmanager/vreplication/vplayer_flaky_test.go#L44
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
	chan child_TestHeartbeatFrequencyFlag440 = [1] of {int};
	run TestHeartbeatFrequencyFlag44(child_TestHeartbeatFrequencyFlag440);
	run receiver(child_TestHeartbeatFrequencyFlag440)
stop_process:skip
}

proctype TestHeartbeatFrequencyFlag44(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef vp_unsavedEvent_state_atomicMessageInfo_initMu;
	Mutexdef vp_replicatorPlan_stats_VReplicationLagRates_mu;
	Mutexdef vp_replicatorPlan_stats_VReplicationLags_mu;
	Mutexdef vp_replicatorPlan_stats_QueryTimings_mu;
	Mutexdef vp_replicatorPlan_stats_PhaseTimings_mu;
	Mutexdef vp_replicatorPlan_stats_State_mu;
	Mutexdef vp_replicatorPlan_stats_History_mu;
	Mutexdef vp_replicatorPlan_stats_heartbeatMutex;
	Mutexdef vp_replicatorPlan_stats_lastPositionMutex;
	Mutexdef vp_replicatorPlan_stats_Rates_mu;
	Mutexdef vp_replicatorPlan_stats_Timings_mu;
	Mutexdef vp_vr_stats_VReplicationLagRates_mu;
	Mutexdef vp_vr_stats_VReplicationLags_mu;
	Mutexdef vp_vr_stats_QueryTimings_mu;
	Mutexdef vp_vr_stats_PhaseTimings_mu;
	Mutexdef vp_vr_stats_State_mu;
	Mutexdef vp_vr_stats_History_mu;
	Mutexdef vp_vr_stats_heartbeatMutex;
	Mutexdef vp_vr_stats_lastPositionMutex;
	Mutexdef vp_vr_stats_Rates_mu;
	Mutexdef vp_vr_stats_Timings_mu;
	Mutexdef vp_vr_dbClient_stats_heartbeatMutex;
	Mutexdef vp_vr_dbClient_stats_lastPositionMutex;
	Mutexdef vp_vr_vre_ec_mu;
	Mutexdef vp_vr_vre_ts_mu;
	Wgdef vp_vr_vre_wg;
	Mutexdef vp_vr_vre_mu;
	Mutexdef stats_VReplicationLagRates_mu;
	Mutexdef stats_VReplicationLags_mu;
	Mutexdef stats_QueryTimings_mu;
	Mutexdef stats_PhaseTimings_mu;
	Mutexdef stats_State_mu;
	Mutexdef stats_History_mu;
	Mutexdef stats_heartbeatMutex;
	Mutexdef stats_lastPositionMutex;
	Mutexdef stats_Rates_mu;
	Mutexdef stats_Timings_mu;
	int var_tcase_counts = -2; // opt var_tcase_counts
	int var_testcases = -2; // opt var_testcases
	run mutexMonitor(stats_Timings_mu);
	run mutexMonitor(stats_Rates_mu);
	run mutexMonitor(stats_lastPositionMutex);
	run mutexMonitor(stats_heartbeatMutex);
	run mutexMonitor(stats_History_mu);
	run mutexMonitor(stats_State_mu);
	run mutexMonitor(stats_PhaseTimings_mu);
	run mutexMonitor(stats_QueryTimings_mu);
	run mutexMonitor(stats_VReplicationLags_mu);
	run mutexMonitor(stats_VReplicationLagRates_mu);
	run mutexMonitor(vp_vr_vre_mu);
	run wgMonitor(vp_vr_vre_wg);
	run mutexMonitor(vp_vr_vre_ts_mu);
	run mutexMonitor(vp_vr_vre_ec_mu);
	run mutexMonitor(vp_vr_dbClient_stats_lastPositionMutex);
	run mutexMonitor(vp_vr_dbClient_stats_heartbeatMutex);
	run mutexMonitor(vp_vr_stats_Timings_mu);
	run mutexMonitor(vp_vr_stats_Rates_mu);
	run mutexMonitor(vp_vr_stats_lastPositionMutex);
	run mutexMonitor(vp_vr_stats_heartbeatMutex);
	run mutexMonitor(vp_vr_stats_History_mu);
	run mutexMonitor(vp_vr_stats_State_mu);
	run mutexMonitor(vp_vr_stats_PhaseTimings_mu);
	run mutexMonitor(vp_vr_stats_QueryTimings_mu);
	run mutexMonitor(vp_vr_stats_VReplicationLags_mu);
	run mutexMonitor(vp_vr_stats_VReplicationLagRates_mu);
	run mutexMonitor(vp_replicatorPlan_stats_Timings_mu);
	run mutexMonitor(vp_replicatorPlan_stats_Rates_mu);
	run mutexMonitor(vp_replicatorPlan_stats_lastPositionMutex);
	run mutexMonitor(vp_replicatorPlan_stats_heartbeatMutex);
	run mutexMonitor(vp_replicatorPlan_stats_History_mu);
	run mutexMonitor(vp_replicatorPlan_stats_State_mu);
	run mutexMonitor(vp_replicatorPlan_stats_PhaseTimings_mu);
	run mutexMonitor(vp_replicatorPlan_stats_QueryTimings_mu);
	run mutexMonitor(vp_replicatorPlan_stats_VReplicationLags_mu);
	run mutexMonitor(vp_replicatorPlan_stats_VReplicationLagRates_mu);
	run mutexMonitor(vp_unsavedEvent_state_atomicMessageInfo_initMu);
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

