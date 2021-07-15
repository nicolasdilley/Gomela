
// https://github.com/hashicorp/vault/blob/master/physical/raft/raft_test.go#L288
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRaft_Backend_ListPrefix2880 = [1] of {int};
	run TestRaft_Backend_ListPrefix288(child_TestRaft_Backend_ListPrefix2880)
stop_process:skip
}

proctype TestRaft_Backend_ListPrefix288(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

