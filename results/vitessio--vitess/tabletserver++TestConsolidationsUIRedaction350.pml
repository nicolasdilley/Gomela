// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/vttablet/tabletserver/query_engine_test.go#L350
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
	chan child_TestConsolidationsUIRedaction3500 = [1] of {int};
	run TestConsolidationsUIRedaction350(child_TestConsolidationsUIRedaction3500);
	run receiver(child_TestConsolidationsUIRedaction3500)
stop_process:skip
}

proctype TestConsolidationsUIRedaction350(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_handleHTTPConsolidations5321 = [1] of {int};
	chan child_handleHTTPConsolidations5320 = [1] of {int};
	Mutexdef qe_accessCheckerLogger_mu;
	Mutexdef qe_consolidatorMode_mu;
	Mutexdef qe_txSerializer_mu;
	Mutexdef qe_txSerializer_logGlobalQueueExceededDryRun_mu;
	Mutexdef qe_txSerializer_logQueueExceededDryRun_mu;
	Mutexdef qe_txSerializer_logWaitsDryRun_mu;
	Mutexdef qe_txSerializer_logDryRun_mu;
	Mutexdef qe_txSerializer_log_mu;
	Mutexdef qe_streamConsolidator_mu;
	Mutexdef qe_consolidator_mu;
	Mutexdef qe_streamConns_dbaPool_connections_reopenMutex;
	Wgdef qe_streamConns_dbaPool_connections_refreshWg;
	Mutexdef qe_streamConns_dbaPool_mu;
	Mutexdef qe_streamConns_connections_reopenMutex;
	Wgdef qe_streamConns_connections_refreshWg;
	Mutexdef qe_streamConns_connections_idleTimer_mu;
	Mutexdef qe_streamConns_mu;
	Mutexdef qe_conns_dbaPool_connections_reopenMutex;
	Wgdef qe_conns_dbaPool_connections_refreshWg;
	Mutexdef qe_conns_dbaPool_mu;
	Mutexdef qe_conns_connections_reopenMutex;
	Wgdef qe_conns_connections_refreshWg;
	Mutexdef qe_conns_connections_idleTimer_mu;
	Mutexdef qe_conns_mu;
	Mutexdef qe_queryRuleSources_mu;
	Mutexdef qe_mu;
	Mutexdef qe_se_ticks_mu;
	Mutexdef qe_se_conns_dbaPool_mu;
	Mutexdef qe_se_conns_connections_reopenMutex;
	Wgdef qe_se_conns_connections_refreshWg;
	Mutexdef qe_se_conns_mu;
	Mutexdef qe_se_historian_mu;
	Mutexdef qe_se_historian_conns_mu;
	Mutexdef qe_se_notifierMu;
	Mutexdef qe_se_mu;
	run mutexMonitor(qe_se_mu);
	run mutexMonitor(qe_se_notifierMu);
	run mutexMonitor(qe_se_historian_conns_mu);
	run mutexMonitor(qe_se_historian_mu);
	run mutexMonitor(qe_se_conns_mu);
	run wgMonitor(qe_se_conns_connections_refreshWg);
	run mutexMonitor(qe_se_conns_connections_reopenMutex);
	run mutexMonitor(qe_se_conns_dbaPool_mu);
	run mutexMonitor(qe_se_ticks_mu);
	run mutexMonitor(qe_mu);
	run mutexMonitor(qe_queryRuleSources_mu);
	run mutexMonitor(qe_conns_mu);
	run mutexMonitor(qe_conns_connections_idleTimer_mu);
	run wgMonitor(qe_conns_connections_refreshWg);
	run mutexMonitor(qe_conns_connections_reopenMutex);
	run mutexMonitor(qe_conns_dbaPool_mu);
	run wgMonitor(qe_conns_dbaPool_connections_refreshWg);
	run mutexMonitor(qe_conns_dbaPool_connections_reopenMutex);
	run mutexMonitor(qe_streamConns_mu);
	run mutexMonitor(qe_streamConns_connections_idleTimer_mu);
	run wgMonitor(qe_streamConns_connections_refreshWg);
	run mutexMonitor(qe_streamConns_connections_reopenMutex);
	run mutexMonitor(qe_streamConns_dbaPool_mu);
	run wgMonitor(qe_streamConns_dbaPool_connections_refreshWg);
	run mutexMonitor(qe_streamConns_dbaPool_connections_reopenMutex);
	run mutexMonitor(qe_consolidator_mu);
	run mutexMonitor(qe_streamConsolidator_mu);
	run mutexMonitor(qe_txSerializer_log_mu);
	run mutexMonitor(qe_txSerializer_logDryRun_mu);
	run mutexMonitor(qe_txSerializer_logWaitsDryRun_mu);
	run mutexMonitor(qe_txSerializer_logQueueExceededDryRun_mu);
	run mutexMonitor(qe_txSerializer_logGlobalQueueExceededDryRun_mu);
	run mutexMonitor(qe_txSerializer_mu);
	run mutexMonitor(qe_consolidatorMode_mu);
	run mutexMonitor(qe_accessCheckerLogger_mu);
	run handleHTTPConsolidations532(qe_conns_connections_refreshWg,qe_conns_dbaPool_connections_refreshWg,qe_se_conns_connections_refreshWg,qe_streamConns_connections_refreshWg,qe_streamConns_dbaPool_connections_refreshWg,qe_accessCheckerLogger_mu,qe_conns_connections_idleTimer_mu,qe_conns_connections_reopenMutex,qe_conns_dbaPool_connections_reopenMutex,qe_conns_dbaPool_mu,qe_conns_mu,qe_consolidator_mu,qe_consolidatorMode_mu,qe_mu,qe_queryRuleSources_mu,qe_se_conns_connections_reopenMutex,qe_se_conns_dbaPool_mu,qe_se_conns_mu,qe_se_historian_conns_mu,qe_se_historian_mu,qe_se_mu,qe_se_notifierMu,qe_se_ticks_mu,qe_streamConns_connections_idleTimer_mu,qe_streamConns_connections_reopenMutex,qe_streamConns_dbaPool_connections_reopenMutex,qe_streamConns_dbaPool_mu,qe_streamConns_mu,qe_streamConsolidator_mu,qe_txSerializer_log_mu,qe_txSerializer_logDryRun_mu,qe_txSerializer_logGlobalQueueExceededDryRun_mu,qe_txSerializer_logQueueExceededDryRun_mu,qe_txSerializer_logWaitsDryRun_mu,qe_txSerializer_mu,child_handleHTTPConsolidations5320);
	child_handleHTTPConsolidations5320?0;
	run handleHTTPConsolidations532(qe_conns_connections_refreshWg,qe_conns_dbaPool_connections_refreshWg,qe_se_conns_connections_refreshWg,qe_streamConns_connections_refreshWg,qe_streamConns_dbaPool_connections_refreshWg,qe_accessCheckerLogger_mu,qe_conns_connections_idleTimer_mu,qe_conns_connections_reopenMutex,qe_conns_dbaPool_connections_reopenMutex,qe_conns_dbaPool_mu,qe_conns_mu,qe_consolidator_mu,qe_consolidatorMode_mu,qe_mu,qe_queryRuleSources_mu,qe_se_conns_connections_reopenMutex,qe_se_conns_dbaPool_mu,qe_se_conns_mu,qe_se_historian_conns_mu,qe_se_historian_mu,qe_se_mu,qe_se_notifierMu,qe_se_ticks_mu,qe_streamConns_connections_idleTimer_mu,qe_streamConns_connections_reopenMutex,qe_streamConns_dbaPool_connections_reopenMutex,qe_streamConns_dbaPool_mu,qe_streamConns_mu,qe_streamConsolidator_mu,qe_txSerializer_log_mu,qe_txSerializer_logDryRun_mu,qe_txSerializer_logGlobalQueueExceededDryRun_mu,qe_txSerializer_logQueueExceededDryRun_mu,qe_txSerializer_logWaitsDryRun_mu,qe_txSerializer_mu,child_handleHTTPConsolidations5321);
	child_handleHTTPConsolidations5321?0;
	stop_process: skip;
	child!0
}
proctype handleHTTPConsolidations532(Wgdef qe_conns_connections_refreshWg;Wgdef qe_conns_dbaPool_connections_refreshWg;Wgdef qe_se_conns_connections_refreshWg;Wgdef qe_streamConns_connections_refreshWg;Wgdef qe_streamConns_dbaPool_connections_refreshWg;Mutexdef qe_accessCheckerLogger_mu;Mutexdef qe_conns_connections_idleTimer_mu;Mutexdef qe_conns_connections_reopenMutex;Mutexdef qe_conns_dbaPool_connections_reopenMutex;Mutexdef qe_conns_dbaPool_mu;Mutexdef qe_conns_mu;Mutexdef qe_consolidator_mu;Mutexdef qe_consolidatorMode_mu;Mutexdef qe_mu;Mutexdef qe_queryRuleSources_mu;Mutexdef qe_se_conns_connections_reopenMutex;Mutexdef qe_se_conns_dbaPool_mu;Mutexdef qe_se_conns_mu;Mutexdef qe_se_historian_conns_mu;Mutexdef qe_se_historian_mu;Mutexdef qe_se_mu;Mutexdef qe_se_notifierMu;Mutexdef qe_se_ticks_mu;Mutexdef qe_streamConns_connections_idleTimer_mu;Mutexdef qe_streamConns_connections_reopenMutex;Mutexdef qe_streamConns_dbaPool_connections_reopenMutex;Mutexdef qe_streamConns_dbaPool_mu;Mutexdef qe_streamConns_mu;Mutexdef qe_streamConsolidator_mu;Mutexdef qe_txSerializer_log_mu;Mutexdef qe_txSerializer_logDryRun_mu;Mutexdef qe_txSerializer_logGlobalQueueExceededDryRun_mu;Mutexdef qe_txSerializer_logQueueExceededDryRun_mu;Mutexdef qe_txSerializer_logWaitsDryRun_mu;Mutexdef qe_txSerializer_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_items = -2; // opt var_items
	

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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

