// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/GoogleContainerTools/skaffold/blob//pkg/skaffold/event/event.go#L156
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_emptyState1560 = [1] of {int};
	run emptyState156(child_emptyState1560);
	run receiver(child_emptyState1560)
stop_process:skip
}

proctype emptyState156(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_emptyStateWithArtifacts1670 = [1] of {int};
	Mutexdef metadata_Test_state_atomicMessageInfo_initMu;
	Mutexdef metadata_Deploy_state_atomicMessageInfo_initMu;
	Mutexdef metadata_Build_state_atomicMessageInfo_initMu;
	Mutexdef metadata_state_atomicMessageInfo_initMu;
	int var_p_Build_Artifacts = -2; // opt var_p_Build_Artifacts
	int var_cfg_GetPipelines = -2; // opt var_cfg_GetPipelines
	run mutexMonitor(metadata_state_atomicMessageInfo_initMu);
	run mutexMonitor(metadata_Build_state_atomicMessageInfo_initMu);
	run mutexMonitor(metadata_Deploy_state_atomicMessageInfo_initMu);
	run mutexMonitor(metadata_Test_state_atomicMessageInfo_initMu);
	run emptyStateWithArtifacts167(metadata_Build_state_atomicMessageInfo_initMu,metadata_Deploy_state_atomicMessageInfo_initMu,metadata_state_atomicMessageInfo_initMu,metadata_Test_state_atomicMessageInfo_initMu,child_emptyStateWithArtifacts1670);
	child_emptyStateWithArtifacts1670?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype emptyStateWithArtifacts167(Mutexdef metadata_Build_state_atomicMessageInfo_initMu;Mutexdef metadata_Deploy_state_atomicMessageInfo_initMu;Mutexdef metadata_state_atomicMessageInfo_initMu;Mutexdef metadata_Test_state_atomicMessageInfo_initMu;chan child) {
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

