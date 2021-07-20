// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/dapr/dapr/blob/ab83d3535478699a2f2707d9ed9008f78c155d6d/pkg/actors/actors_test.go#L945
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
	chan child_TestShutdown9450 = [1] of {int};
	run TestShutdown945(child_TestShutdown9450);
	run receiver(child_TestShutdown9450)
stop_process:skip
}

proctype TestShutdown945(chan child) {
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

proctype receiver(chan c) {
c?0
}

