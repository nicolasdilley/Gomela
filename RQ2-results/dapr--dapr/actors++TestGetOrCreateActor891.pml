
// https://github.com/dapr/dapr/blob/master/pkg/actors/actors_test.go#L891
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
	chan child_TestGetOrCreateActor8910 = [1] of {int};
	run TestGetOrCreateActor891(child_TestGetOrCreateActor8910)
stop_process:skip
}

proctype TestGetOrCreateActor891(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef testActorRuntime_evaluationLock;
	Mutexdef testActorRuntime_activeRemindersLock;
	Mutexdef testActorRuntime_remindersLock;
	Mutexdef testActorRuntime_activeReminders_mu;
	Mutexdef testActorRuntime_activeTimersLock;
	Mutexdef testActorRuntime_activeTimers_mu;
	Mutexdef testActorRuntime_actorsTable_mu;
	Wgdef testActorRuntime_placement_shutdownConnLoop;
	Mutexdef testActorRuntime_placement_operationUpdateLock;
	Mutexdef testActorRuntime_placement_placementTableLock;
	Mutexdef testActorRuntime_placement_clientConn_lceMu;
	Mutexdef testActorRuntime_placement_clientConn_firstResolveEvent_o_m;
	Mutexdef testActorRuntime_placement_clientConn_balancerWrapper_mu;
	Mutexdef testActorRuntime_placement_clientConn_balancerWrapper_done_o_m;
	Mutexdef testActorRuntime_placement_clientConn_balancerWrapper_scBuffer_mu;
	Mutexdef testActorRuntime_placement_clientConn_balancerWrapper_balancerMu;
	Mutexdef testActorRuntime_placement_clientConn_resolverWrapper_pollingMu;
	Mutexdef testActorRuntime_placement_clientConn_resolverWrapper_done_o_m;
	Mutexdef testActorRuntime_placement_clientConn_resolverWrapper_resolverMu;
	Mutexdef testActorRuntime_placement_clientConn_mu;
	Mutexdef testActorRuntime_placement_clientConn_safeConfigSelector_mu;
	Mutexdef testActorRuntime_placement_clientConn_blockingpicker_mu;
	Mutexdef testActorRuntime_placement_clientConn_csMgr_mu;
	run mutexMonitor(testActorRuntime_placement_clientConn_csMgr_mu);
	run mutexMonitor(testActorRuntime_placement_clientConn_blockingpicker_mu);
	run mutexMonitor(testActorRuntime_placement_clientConn_safeConfigSelector_mu);
	run mutexMonitor(testActorRuntime_placement_clientConn_mu);
	run mutexMonitor(testActorRuntime_placement_clientConn_resolverWrapper_resolverMu);
	run mutexMonitor(testActorRuntime_placement_clientConn_resolverWrapper_done_o_m);
	run mutexMonitor(testActorRuntime_placement_clientConn_resolverWrapper_pollingMu);
	run mutexMonitor(testActorRuntime_placement_clientConn_balancerWrapper_balancerMu);
	run mutexMonitor(testActorRuntime_placement_clientConn_balancerWrapper_scBuffer_mu);
	run mutexMonitor(testActorRuntime_placement_clientConn_balancerWrapper_done_o_m);
	run mutexMonitor(testActorRuntime_placement_clientConn_balancerWrapper_mu);
	run mutexMonitor(testActorRuntime_placement_clientConn_firstResolveEvent_o_m);
	run mutexMonitor(testActorRuntime_placement_clientConn_lceMu);
	run mutexMonitor(testActorRuntime_placement_placementTableLock);
	run mutexMonitor(testActorRuntime_placement_operationUpdateLock);
	run wgMonitor(testActorRuntime_placement_shutdownConnLoop);
	run mutexMonitor(testActorRuntime_actorsTable_mu);
	run mutexMonitor(testActorRuntime_activeTimers_mu);
	run mutexMonitor(testActorRuntime_activeTimersLock);
	run mutexMonitor(testActorRuntime_activeReminders_mu);
	run mutexMonitor(testActorRuntime_remindersLock);
	run mutexMonitor(testActorRuntime_activeRemindersLock);
	run mutexMonitor(testActorRuntime_evaluationLock);
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

