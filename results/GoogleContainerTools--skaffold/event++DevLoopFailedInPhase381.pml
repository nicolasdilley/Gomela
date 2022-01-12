// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/GoogleContainerTools/skaffold/blob//pkg/skaffold/event/event.go#L381
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_DevLoopFailedInPhase3810 = [1] of {int};
	run DevLoopFailedInPhase381(child_DevLoopFailedInPhase3810);
	run receiver(child_DevLoopFailedInPhase3810)
stop_process:skip
}

proctype DevLoopFailedInPhase381(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef ai_state_atomicMessageInfo_initMu;
	Mutexdef state_TestState_state_atomicMessageInfo_initMu;
	Mutexdef state_Metadata_state_atomicMessageInfo_initMu;
	Mutexdef state_FileSyncState_state_atomicMessageInfo_initMu;
	Mutexdef state_StatusCheckState_state_atomicMessageInfo_initMu;
	Mutexdef state_DeployState_state_atomicMessageInfo_initMu;
	Mutexdef state_BuildState_state_atomicMessageInfo_initMu;
	Mutexdef state_state_atomicMessageInfo_initMu;
	run mutexMonitor(state_state_atomicMessageInfo_initMu);
	run mutexMonitor(state_BuildState_state_atomicMessageInfo_initMu);
	run mutexMonitor(state_DeployState_state_atomicMessageInfo_initMu);
	run mutexMonitor(state_StatusCheckState_state_atomicMessageInfo_initMu);
	run mutexMonitor(state_FileSyncState_state_atomicMessageInfo_initMu);
	run mutexMonitor(state_Metadata_state_atomicMessageInfo_initMu);
	run mutexMonitor(state_TestState_state_atomicMessageInfo_initMu);
	

	if
	:: true;
	:: true;
	:: true;
	:: true;
	:: true -> 
		run mutexMonitor(ai_state_atomicMessageInfo_initMu)
	fi;
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

