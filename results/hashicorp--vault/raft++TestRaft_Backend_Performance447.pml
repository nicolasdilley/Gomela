// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/vault/blob//physical/raft/raft_test.go#L447
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRaft_Backend_Performance4470 = [1] of {int};
	run TestRaft_Backend_Performance447(child_TestRaft_Backend_Performance4470);
	run receiver(child_TestRaft_Backend_Performance4470)
stop_process:skip
}

proctype TestRaft_Backend_Performance447(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_applyConfigSettings5872 = [1] of {int};
	chan child_applyConfigSettings5871 = [1] of {int};
	chan child_applyConfigSettings5870 = [1] of {int};
	Mutexdef b_followerStates_l;
	Mutexdef b_autopilot_execLock;
	Mutexdef b_autopilot_leaderLock_mu;
	Mutexdef b_autopilot_stateLock;
	Mutexdef b_streamLayer_closeLock;
	Mutexdef b_raft_observersLock;
	Mutexdef b_raft_shutdownLock;
	Mutexdef b_raft_leaderLock;
	Mutexdef b_raft_lastContactLock;
	Mutexdef b_fsm_db_statlock;
	Mutexdef b_fsm_db_mmaplock;
	Mutexdef b_fsm_db_metalock;
	Mutexdef b_fsm_db_rwlock;
	Mutexdef b_fsm_db_batchMu;
	Mutexdef b_fsm_db_freelistLoad_m;
	Mutexdef b_fsm_l;
	Mutexdef b_l;
	run mutexMonitor(b_l);
	run mutexMonitor(b_fsm_l);
	run mutexMonitor(b_fsm_db_freelistLoad_m);
	run mutexMonitor(b_fsm_db_batchMu);
	run mutexMonitor(b_fsm_db_rwlock);
	run mutexMonitor(b_fsm_db_metalock);
	run mutexMonitor(b_fsm_db_mmaplock);
	run mutexMonitor(b_fsm_db_statlock);
	run mutexMonitor(b_raft_lastContactLock);
	run mutexMonitor(b_raft_leaderLock);
	run mutexMonitor(b_raft_shutdownLock);
	run mutexMonitor(b_raft_observersLock);
	run mutexMonitor(b_streamLayer_closeLock);
	run mutexMonitor(b_autopilot_stateLock);
	run mutexMonitor(b_autopilot_leaderLock_mu);
	run mutexMonitor(b_autopilot_execLock);
	run mutexMonitor(b_followerStates_l);
	run applyConfigSettings587(b_autopilot_execLock,b_autopilot_leaderLock_mu,b_autopilot_stateLock,b_followerStates_l,b_fsm_db_batchMu,b_fsm_db_freelistLoad_m,b_fsm_db_metalock,b_fsm_db_mmaplock,b_fsm_db_rwlock,b_fsm_db_statlock,b_fsm_l,b_l,b_raft_lastContactLock,b_raft_leaderLock,b_raft_observersLock,b_raft_shutdownLock,b_streamLayer_closeLock,child_applyConfigSettings5870);
	child_applyConfigSettings5870?0;
	run applyConfigSettings587(b_autopilot_execLock,b_autopilot_leaderLock_mu,b_autopilot_stateLock,b_followerStates_l,b_fsm_db_batchMu,b_fsm_db_freelistLoad_m,b_fsm_db_metalock,b_fsm_db_mmaplock,b_fsm_db_rwlock,b_fsm_db_statlock,b_fsm_l,b_l,b_raft_lastContactLock,b_raft_leaderLock,b_raft_observersLock,b_raft_shutdownLock,b_streamLayer_closeLock,child_applyConfigSettings5871);
	child_applyConfigSettings5871?0;
	run applyConfigSettings587(b_autopilot_execLock,b_autopilot_leaderLock_mu,b_autopilot_stateLock,b_followerStates_l,b_fsm_db_batchMu,b_fsm_db_freelistLoad_m,b_fsm_db_metalock,b_fsm_db_mmaplock,b_fsm_db_rwlock,b_fsm_db_statlock,b_fsm_l,b_l,b_raft_lastContactLock,b_raft_leaderLock,b_raft_observersLock,b_raft_shutdownLock,b_streamLayer_closeLock,child_applyConfigSettings5872);
	child_applyConfigSettings5872?0;
	stop_process: skip;
	child!0
}
proctype applyConfigSettings587(Mutexdef b_autopilot_execLock;Mutexdef b_autopilot_leaderLock_mu;Mutexdef b_autopilot_stateLock;Mutexdef b_followerStates_l;Mutexdef b_fsm_db_batchMu;Mutexdef b_fsm_db_freelistLoad_m;Mutexdef b_fsm_db_metalock;Mutexdef b_fsm_db_mmaplock;Mutexdef b_fsm_db_rwlock;Mutexdef b_fsm_db_statlock;Mutexdef b_fsm_l;Mutexdef b_l;Mutexdef b_raft_lastContactLock;Mutexdef b_raft_leaderLock;Mutexdef b_raft_observersLock;Mutexdef b_raft_shutdownLock;Mutexdef b_streamLayer_closeLock;chan child) {
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

