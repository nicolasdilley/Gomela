
// https://github.com/hashicorp/vault/blob/master/physical/raft/snapshot_test.go#L141
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRaft_Snapshot_Index1410 = [1] of {int};
	run TestRaft_Snapshot_Index141(child_TestRaft_Snapshot_Index1410)
stop_process:skip
}

proctype TestRaft_Snapshot_Index141(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Put11787 = [1] of {int};
	chan child_Put11786 = [1] of {int};
	chan child_Snapshot7425 = [1] of {int};
	chan child_LatestState3924 = [1] of {int};
	chan child_Put11783 = [1] of {int};
	chan child_Put11782 = [1] of {int};
	chan child_LatestState3921 = [1] of {int};
	Mutexdef __state_atomicMessageInfo_initMu;
	Mutexdef index_state_atomicMessageInfo_initMu;
	chan child_Put11780 = [1] of {int};
	Mutexdef raft_followerStates_l;
	Mutexdef raft_autopilot_execLock;
	Mutexdef raft_autopilot_leaderLock_mu;
	Mutexdef raft_autopilot_stateLock;
	Mutexdef raft_streamLayer_closeLock;
	Mutexdef raft_raft_observersLock;
	Mutexdef raft_raft_shutdownLock;
	Mutexdef raft_raft_leaderLock;
	Mutexdef raft_raft_lastContactLock;
	Mutexdef raft_fsm_db_statlock;
	Mutexdef raft_fsm_db_mmaplock;
	Mutexdef raft_fsm_db_metalock;
	Mutexdef raft_fsm_db_rwlock;
	Mutexdef raft_fsm_db_batch_start_m;
	Mutexdef raft_fsm_db_batchMu;
	Mutexdef raft_fsm_db_freelistLoad_m;
	Mutexdef raft_fsm_l;
	Mutexdef raft_l;
	run mutexMonitor(raft_l);
	run mutexMonitor(raft_fsm_l);
	run mutexMonitor(raft_fsm_db_freelistLoad_m);
	run mutexMonitor(raft_fsm_db_batchMu);
	run mutexMonitor(raft_fsm_db_batch_start_m);
	run mutexMonitor(raft_fsm_db_rwlock);
	run mutexMonitor(raft_fsm_db_metalock);
	run mutexMonitor(raft_fsm_db_mmaplock);
	run mutexMonitor(raft_fsm_db_statlock);
	run mutexMonitor(raft_raft_lastContactLock);
	run mutexMonitor(raft_raft_leaderLock);
	run mutexMonitor(raft_raft_shutdownLock);
	run mutexMonitor(raft_raft_observersLock);
	run mutexMonitor(raft_streamLayer_closeLock);
	run mutexMonitor(raft_autopilot_stateLock);
	run mutexMonitor(raft_autopilot_leaderLock_mu);
	run mutexMonitor(raft_autopilot_execLock);
	run mutexMonitor(raft_followerStates_l);
	run Put1178(raft_l,raft_fsm_l,raft_fsm_db_freelistLoad_m,raft_fsm_db_batchMu,raft_fsm_db_batch_start_m,raft_fsm_db_rwlock,raft_fsm_db_metalock,raft_fsm_db_mmaplock,raft_fsm_db_statlock,raft_raft_lastContactLock,raft_raft_leaderLock,raft_raft_shutdownLock,raft_raft_observersLock,raft_streamLayer_closeLock,raft_autopilot_stateLock,raft_autopilot_leaderLock_mu,raft_autopilot_execLock,raft_followerStates_l,child_Put11780);
	child_Put11780?0;
	run mutexMonitor(index_state_atomicMessageInfo_initMu);
	run mutexMonitor(__state_atomicMessageInfo_initMu);
	run LatestState392(raft_fsm_l,raft_fsm_db_freelistLoad_m,raft_fsm_db_batchMu,raft_fsm_db_batch_start_m,raft_fsm_db_rwlock,raft_fsm_db_metalock,raft_fsm_db_mmaplock,raft_fsm_db_statlock,child_LatestState3921);
	child_LatestState3921?0;
	

	if
	:: 0 != -2 && 100-1 != -3 -> 
				for(i : 0.. 100-1) {
			for11: skip;
			run Put1178(raft_l,raft_fsm_l,raft_fsm_db_freelistLoad_m,raft_fsm_db_batchMu,raft_fsm_db_batch_start_m,raft_fsm_db_rwlock,raft_fsm_db_metalock,raft_fsm_db_mmaplock,raft_fsm_db_statlock,raft_raft_lastContactLock,raft_raft_leaderLock,raft_raft_shutdownLock,raft_raft_observersLock,raft_streamLayer_closeLock,raft_autopilot_stateLock,raft_autopilot_leaderLock_mu,raft_autopilot_execLock,raft_followerStates_l,child_Put11783);
			child_Put11783?0;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run Put1178(raft_l,raft_fsm_l,raft_fsm_db_freelistLoad_m,raft_fsm_db_batchMu,raft_fsm_db_batch_start_m,raft_fsm_db_rwlock,raft_fsm_db_metalock,raft_fsm_db_mmaplock,raft_fsm_db_statlock,raft_raft_lastContactLock,raft_raft_leaderLock,raft_raft_shutdownLock,raft_raft_observersLock,raft_streamLayer_closeLock,raft_autopilot_stateLock,raft_autopilot_leaderLock_mu,raft_autopilot_execLock,raft_followerStates_l,child_Put11782);
			child_Put11782?0;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	run LatestState392(raft_fsm_l,raft_fsm_db_freelistLoad_m,raft_fsm_db_batchMu,raft_fsm_db_batch_start_m,raft_fsm_db_rwlock,raft_fsm_db_metalock,raft_fsm_db_mmaplock,raft_fsm_db_statlock,child_LatestState3924);
	child_LatestState3924?0;
	run Snapshot742(raft_raft_lastContactLock,raft_raft_leaderLock,raft_raft_shutdownLock,raft_raft_observersLock,child_Snapshot7425);
	child_Snapshot7425?0;
	

	if
	:: 0 != -2 && 100-1 != -3 -> 
				for(i : 0.. 100-1) {
			for21: skip;
			run Put1178(raft_l,raft_fsm_l,raft_fsm_db_freelistLoad_m,raft_fsm_db_batchMu,raft_fsm_db_batch_start_m,raft_fsm_db_rwlock,raft_fsm_db_metalock,raft_fsm_db_mmaplock,raft_fsm_db_statlock,raft_raft_lastContactLock,raft_raft_leaderLock,raft_raft_shutdownLock,raft_raft_observersLock,raft_streamLayer_closeLock,raft_autopilot_stateLock,raft_autopilot_leaderLock_mu,raft_autopilot_execLock,raft_followerStates_l,child_Put11787);
			child_Put11787?0;
			for21_end: skip
		};
		for21_exit: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			run Put1178(raft_l,raft_fsm_l,raft_fsm_db_freelistLoad_m,raft_fsm_db_batchMu,raft_fsm_db_batch_start_m,raft_fsm_db_rwlock,raft_fsm_db_metalock,raft_fsm_db_mmaplock,raft_fsm_db_statlock,raft_raft_lastContactLock,raft_raft_leaderLock,raft_raft_shutdownLock,raft_raft_observersLock,raft_streamLayer_closeLock,raft_autopilot_stateLock,raft_autopilot_leaderLock_mu,raft_autopilot_execLock,raft_followerStates_l,child_Put11786);
			child_Put11786?0;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
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
proctype LatestState392(Mutexdef f_l;Mutexdef f_db_freelistLoad_m;Mutexdef f_db_batchMu;Mutexdef f_db_batch_start_m;Mutexdef f_db_rwlock;Mutexdef f_db_metalock;Mutexdef f_db_mmaplock;Mutexdef f_db_statlock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Snapshot742(Mutexdef f_lastContactLock;Mutexdef f_leaderLock;Mutexdef f_shutdownLock;Mutexdef f_observersLock;chan child) {
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

