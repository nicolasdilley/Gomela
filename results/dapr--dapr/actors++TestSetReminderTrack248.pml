
// https://github.com/dapr/dapr/blob/master/pkg/actors/actors_test.go#L248
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
	chan child_TestSetReminderTrack2480 = [1] of {int};
	run TestSetReminderTrack248(child_TestSetReminderTrack2480)
stop_process:skip
}

proctype TestSetReminderTrack248(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_updateReminderTrack5940 = [1] of {int};
	Mutexdef testActorsRuntime_evaluationLock;
	Mutexdef testActorsRuntime_activeRemindersLock;
	Mutexdef testActorsRuntime_remindersLock;
	Mutexdef testActorsRuntime_activeReminders_mu;
	Mutexdef testActorsRuntime_activeTimersLock;
	Mutexdef testActorsRuntime_activeTimers_mu;
	Mutexdef testActorsRuntime_actorsTable_mu;
	Wgdef testActorsRuntime_placement_shutdownConnLoop;
	Mutexdef testActorsRuntime_placement_operationUpdateLock;
	Mutexdef testActorsRuntime_placement_placementTableLock;
	Mutexdef testActorsRuntime_placement_clientConn_lceMu;
	Mutexdef testActorsRuntime_placement_clientConn_firstResolveEvent_o_m;
	Mutexdef testActorsRuntime_placement_clientConn_balancerWrapper_mu;
	Mutexdef testActorsRuntime_placement_clientConn_balancerWrapper_done_o_m;
	Mutexdef testActorsRuntime_placement_clientConn_balancerWrapper_scBuffer_mu;
	Mutexdef testActorsRuntime_placement_clientConn_balancerWrapper_balancerMu;
	Mutexdef testActorsRuntime_placement_clientConn_resolverWrapper_pollingMu;
	Mutexdef testActorsRuntime_placement_clientConn_resolverWrapper_done_o_m;
	Mutexdef testActorsRuntime_placement_clientConn_resolverWrapper_resolverMu;
	Mutexdef testActorsRuntime_placement_clientConn_mu;
	Mutexdef testActorsRuntime_placement_clientConn_safeConfigSelector_mu;
	Mutexdef testActorsRuntime_placement_clientConn_blockingpicker_mu;
	Mutexdef testActorsRuntime_placement_clientConn_csMgr_mu;
	run mutexMonitor(testActorsRuntime_placement_clientConn_csMgr_mu);
	run mutexMonitor(testActorsRuntime_placement_clientConn_blockingpicker_mu);
	run mutexMonitor(testActorsRuntime_placement_clientConn_safeConfigSelector_mu);
	run mutexMonitor(testActorsRuntime_placement_clientConn_mu);
	run mutexMonitor(testActorsRuntime_placement_clientConn_resolverWrapper_resolverMu);
	run mutexMonitor(testActorsRuntime_placement_clientConn_resolverWrapper_done_o_m);
	run mutexMonitor(testActorsRuntime_placement_clientConn_resolverWrapper_pollingMu);
	run mutexMonitor(testActorsRuntime_placement_clientConn_balancerWrapper_balancerMu);
	run mutexMonitor(testActorsRuntime_placement_clientConn_balancerWrapper_scBuffer_mu);
	run mutexMonitor(testActorsRuntime_placement_clientConn_balancerWrapper_done_o_m);
	run mutexMonitor(testActorsRuntime_placement_clientConn_balancerWrapper_mu);
	run mutexMonitor(testActorsRuntime_placement_clientConn_firstResolveEvent_o_m);
	run mutexMonitor(testActorsRuntime_placement_clientConn_lceMu);
	run mutexMonitor(testActorsRuntime_placement_placementTableLock);
	run mutexMonitor(testActorsRuntime_placement_operationUpdateLock);
	run wgMonitor(testActorsRuntime_placement_shutdownConnLoop);
	run mutexMonitor(testActorsRuntime_actorsTable_mu);
	run mutexMonitor(testActorsRuntime_activeTimers_mu);
	run mutexMonitor(testActorsRuntime_activeTimersLock);
	run mutexMonitor(testActorsRuntime_activeReminders_mu);
	run mutexMonitor(testActorsRuntime_remindersLock);
	run mutexMonitor(testActorsRuntime_activeRemindersLock);
	run mutexMonitor(testActorsRuntime_evaluationLock);
	run updateReminderTrack594(testActorsRuntime_placement_shutdownConnLoop,testActorsRuntime_placement_clientConn_csMgr_mu,testActorsRuntime_placement_clientConn_blockingpicker_mu,testActorsRuntime_placement_clientConn_safeConfigSelector_mu,testActorsRuntime_placement_clientConn_mu,testActorsRuntime_placement_clientConn_resolverWrapper_resolverMu,testActorsRuntime_placement_clientConn_resolverWrapper_done_o_m,testActorsRuntime_placement_clientConn_resolverWrapper_pollingMu,testActorsRuntime_placement_clientConn_balancerWrapper_balancerMu,testActorsRuntime_placement_clientConn_balancerWrapper_scBuffer_mu,testActorsRuntime_placement_clientConn_balancerWrapper_done_o_m,testActorsRuntime_placement_clientConn_balancerWrapper_mu,testActorsRuntime_placement_clientConn_firstResolveEvent_o_m,testActorsRuntime_placement_clientConn_lceMu,testActorsRuntime_placement_placementTableLock,testActorsRuntime_placement_operationUpdateLock,testActorsRuntime_actorsTable_mu,testActorsRuntime_activeTimers_mu,testActorsRuntime_activeTimersLock,testActorsRuntime_activeReminders_mu,testActorsRuntime_remindersLock,testActorsRuntime_activeRemindersLock,testActorsRuntime_evaluationLock,child_updateReminderTrack5940);
	child_updateReminderTrack5940?0;
	stop_process: skip;
	child!0
}
proctype updateReminderTrack594(Wgdef a_placement_shutdownConnLoop;Mutexdef a_placement_clientConn_csMgr_mu;Mutexdef a_placement_clientConn_blockingpicker_mu;Mutexdef a_placement_clientConn_safeConfigSelector_mu;Mutexdef a_placement_clientConn_mu;Mutexdef a_placement_clientConn_resolverWrapper_resolverMu;Mutexdef a_placement_clientConn_resolverWrapper_done_o_m;Mutexdef a_placement_clientConn_resolverWrapper_pollingMu;Mutexdef a_placement_clientConn_balancerWrapper_balancerMu;Mutexdef a_placement_clientConn_balancerWrapper_scBuffer_mu;Mutexdef a_placement_clientConn_balancerWrapper_done_o_m;Mutexdef a_placement_clientConn_balancerWrapper_mu;Mutexdef a_placement_clientConn_firstResolveEvent_o_m;Mutexdef a_placement_clientConn_lceMu;Mutexdef a_placement_placementTableLock;Mutexdef a_placement_operationUpdateLock;Mutexdef a_actorsTable_mu;Mutexdef a_activeTimers_mu;Mutexdef a_activeTimersLock;Mutexdef a_activeReminders_mu;Mutexdef a_remindersLock;Mutexdef a_activeRemindersLock;Mutexdef a_evaluationLock;chan child) {
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

