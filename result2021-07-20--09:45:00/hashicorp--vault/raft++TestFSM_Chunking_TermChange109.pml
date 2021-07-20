// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/vault/blob/f8f289712a3d37115090591602a2b92503fb3a13/physical/raft/chunking_test.go#L109
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFSM_Chunking_TermChange1090 = [1] of {int};
	run TestFSM_Chunking_TermChange109(child_TestFSM_Chunking_TermChange1090);
	run receiver(child_TestFSM_Chunking_TermChange1090)
stop_process:skip
}

proctype TestFSM_Chunking_TermChange109(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_applyConfigSettings5870 = [1] of {int};
	Mutexdef b_followerStates_l;
	Mutexdef b_autopilot_execLock;
	Mutexdef b_autopilot_stateLock;
	Mutexdef b_streamLayer_closeLock;
	Mutexdef b_raft_observersLock;
	Mutexdef b_raft_shutdownLock;
	Mutexdef b_raft_leaderLock;
	Mutexdef b_raft_lastContactLock;
	Mutexdef b_fsm_l;
	Mutexdef b_l;
	int var_logslogs = -2; // opt var_logslogs
	int var_chunkschunks = -2; // opt var_chunkschunks
	run mutexMonitor(b_l);
	run mutexMonitor(b_fsm_l);
	run mutexMonitor(b_raft_lastContactLock);
	run mutexMonitor(b_raft_leaderLock);
	run mutexMonitor(b_raft_shutdownLock);
	run mutexMonitor(b_raft_observersLock);
	run mutexMonitor(b_streamLayer_closeLock);
	run mutexMonitor(b_autopilot_stateLock);
	run mutexMonitor(b_autopilot_execLock);
	run mutexMonitor(b_followerStates_l);
	run applyConfigSettings587(b_autopilot_execLock,b_autopilot_stateLock,b_followerStates_l,b_fsm_l,b_l,b_raft_lastContactLock,b_raft_leaderLock,b_raft_observersLock,b_raft_shutdownLock,b_streamLayer_closeLock,child_applyConfigSettings5870);
	child_applyConfigSettings5870?0;
	stop_process: skip;
	child!0
}
proctype applyConfigSettings587(Mutexdef b_autopilot_execLock;Mutexdef b_autopilot_stateLock;Mutexdef b_followerStates_l;Mutexdef b_fsm_l;Mutexdef b_l;Mutexdef b_raft_lastContactLock;Mutexdef b_raft_leaderLock;Mutexdef b_raft_observersLock;Mutexdef b_raft_shutdownLock;Mutexdef b_streamLayer_closeLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
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

