
// https://github.com/hashicorp/vault/blob/master/physical/raft/raft_test.go#L227
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRaft_Backend_LargeValue2270 = [1] of {int};
	run TestRaft_Backend_LargeValue227(child_TestRaft_Backend_LargeValue2270)
stop_process:skip
}

proctype TestRaft_Backend_LargeValue227(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Get11521 = [1] of {int};
	chan child_Put11780 = [1] of {int};
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
	Mutexdef b_fsm_db_batch_start_m;
	Mutexdef b_fsm_db_batchMu;
	Mutexdef b_fsm_db_freelistLoad_m;
	Mutexdef b_fsm_l;
	Mutexdef b_l;
	run mutexMonitor(b_l);
	run mutexMonitor(b_fsm_l);
	run mutexMonitor(b_fsm_db_freelistLoad_m);
	run mutexMonitor(b_fsm_db_batchMu);
	run mutexMonitor(b_fsm_db_batch_start_m);
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
	run Put1178(b_l,b_fsm_l,b_fsm_db_freelistLoad_m,b_fsm_db_batchMu,b_fsm_db_batch_start_m,b_fsm_db_rwlock,b_fsm_db_metalock,b_fsm_db_mmaplock,b_fsm_db_statlock,b_raft_lastContactLock,b_raft_leaderLock,b_raft_shutdownLock,b_raft_observersLock,b_streamLayer_closeLock,b_autopilot_stateLock,b_autopilot_leaderLock_mu,b_autopilot_execLock,b_followerStates_l,child_Put11780);
	child_Put11780?0;
	run Get1152(b_l,b_fsm_l,b_fsm_db_freelistLoad_m,b_fsm_db_batchMu,b_fsm_db_batch_start_m,b_fsm_db_rwlock,b_fsm_db_metalock,b_fsm_db_mmaplock,b_fsm_db_statlock,b_raft_lastContactLock,b_raft_leaderLock,b_raft_shutdownLock,b_raft_observersLock,b_streamLayer_closeLock,b_autopilot_stateLock,b_autopilot_leaderLock_mu,b_autopilot_execLock,b_followerStates_l,child_Get11521);
	child_Get11521?0;
	stop_process: skip;
	child!0
}
proctype Put1178(Mutexdef b_l;Mutexdef b_fsm_l;Mutexdef b_fsm_db_freelistLoad_m;Mutexdef b_fsm_db_batchMu;Mutexdef b_fsm_db_batch_start_m;Mutexdef b_fsm_db_rwlock;Mutexdef b_fsm_db_metalock;Mutexdef b_fsm_db_mmaplock;Mutexdef b_fsm_db_statlock;Mutexdef b_raft_lastContactLock;Mutexdef b_raft_leaderLock;Mutexdef b_raft_shutdownLock;Mutexdef b_raft_observersLock;Mutexdef b_streamLayer_closeLock;Mutexdef b_autopilot_stateLock;Mutexdef b_autopilot_leaderLock_mu;Mutexdef b_autopilot_execLock;Mutexdef b_followerStates_l;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_applyLog12480 = [1] of {int};
	Mutexdef command_state_atomicMessageInfo_initMu;
	run mutexMonitor(command_state_atomicMessageInfo_initMu);
	b_l.RLock!false;
	run applyLog1248(b_l,b_fsm_l,b_fsm_db_freelistLoad_m,b_fsm_db_batchMu,b_fsm_db_batch_start_m,b_fsm_db_rwlock,b_fsm_db_metalock,b_fsm_db_mmaplock,b_fsm_db_statlock,b_raft_lastContactLock,b_raft_leaderLock,b_raft_shutdownLock,b_raft_observersLock,b_streamLayer_closeLock,b_autopilot_stateLock,b_autopilot_leaderLock_mu,b_autopilot_execLock,b_followerStates_l,command_state_atomicMessageInfo_initMu,child_applyLog12480);
	child_applyLog12480?0;
	b_l.RUnlock!false;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype applyLog1248(Mutexdef b_l;Mutexdef b_fsm_l;Mutexdef b_fsm_db_freelistLoad_m;Mutexdef b_fsm_db_batchMu;Mutexdef b_fsm_db_batch_start_m;Mutexdef b_fsm_db_rwlock;Mutexdef b_fsm_db_metalock;Mutexdef b_fsm_db_mmaplock;Mutexdef b_fsm_db_statlock;Mutexdef b_raft_lastContactLock;Mutexdef b_raft_leaderLock;Mutexdef b_raft_shutdownLock;Mutexdef b_raft_observersLock;Mutexdef b_streamLayer_closeLock;Mutexdef b_autopilot_stateLock;Mutexdef b_autopilot_leaderLock_mu;Mutexdef b_autopilot_execLock;Mutexdef b_followerStates_l;Mutexdef command_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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
	

	if
	:: true;
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Get1152(Mutexdef b_l;Mutexdef b_fsm_l;Mutexdef b_fsm_db_freelistLoad_m;Mutexdef b_fsm_db_batchMu;Mutexdef b_fsm_db_batch_start_m;Mutexdef b_fsm_db_rwlock;Mutexdef b_fsm_db_metalock;Mutexdef b_fsm_db_mmaplock;Mutexdef b_fsm_db_statlock;Mutexdef b_raft_lastContactLock;Mutexdef b_raft_leaderLock;Mutexdef b_raft_shutdownLock;Mutexdef b_raft_observersLock;Mutexdef b_streamLayer_closeLock;Mutexdef b_autopilot_stateLock;Mutexdef b_autopilot_leaderLock_mu;Mutexdef b_autopilot_execLock;Mutexdef b_followerStates_l;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Get4361 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Get436(b_fsm_l,b_fsm_db_freelistLoad_m,b_fsm_db_batchMu,b_fsm_db_batch_start_m,b_fsm_db_rwlock,b_fsm_db_metalock,b_fsm_db_mmaplock,b_fsm_db_statlock,child_Get4361);
	child_Get4361?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Get436(Mutexdef f_l;Mutexdef f_db_freelistLoad_m;Mutexdef f_db_batchMu;Mutexdef f_db_batch_start_m;Mutexdef f_db_rwlock;Mutexdef f_db_metalock;Mutexdef f_db_mmaplock;Mutexdef f_db_statlock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	f_l.RLock!false;
	

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
	goto stop_process;
	stop_process: skip;
		f_l.RUnlock!false;
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

