// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/hashicorp/vault/blob/f8f289712a3d37115090591602a2b92503fb3a13/physical/raft/raft_test.go#L253
#define not_found_270  -2 // opt txns line 1247
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRaft_TransactionalBackend_LargeValue2530 = [1] of {int};
	run TestRaft_TransactionalBackend_LargeValue253(child_TestRaft_TransactionalBackend_LargeValue2530);
	run receiver(child_TestRaft_TransactionalBackend_LargeValue2530)
stop_process:skip
}

proctype TestRaft_TransactionalBackend_LargeValue253(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Get11851 = [1] of {int};
	chan child_Transaction12470 = [1] of {int};
	Mutexdef b_followerStates_l;
	Mutexdef b_autopilot_execLock;
	Mutexdef b_autopilot_stateLock;
	Mutexdef b_streamLayer_closeLock;
	Mutexdef b_raft_observersLock;
	Mutexdef b_raft_shutdownLock;
	Mutexdef b_raft_leaderLock;
	Mutexdef b_raft_lastContactLock;
	Mutexdef b_raft_confReloadMu;
	Mutexdef b_fsm_l;
	Mutexdef b_l;
	run mutexMonitor(b_l);
	run mutexMonitor(b_fsm_l);
	run mutexMonitor(b_raft_confReloadMu);
	run mutexMonitor(b_raft_lastContactLock);
	run mutexMonitor(b_raft_leaderLock);
	run mutexMonitor(b_raft_shutdownLock);
	run mutexMonitor(b_raft_observersLock);
	run mutexMonitor(b_streamLayer_closeLock);
	run mutexMonitor(b_autopilot_stateLock);
	run mutexMonitor(b_autopilot_execLock);
	run mutexMonitor(b_followerStates_l);
	run Transaction1247(b_autopilot_execLock,b_autopilot_stateLock,b_followerStates_l,b_fsm_l,b_l,b_raft_confReloadMu,b_raft_lastContactLock,b_raft_leaderLock,b_raft_observersLock,b_raft_shutdownLock,b_streamLayer_closeLock,not_found_270,child_Transaction12470);
	child_Transaction12470?0;
	run Get1185(b_autopilot_execLock,b_autopilot_stateLock,b_followerStates_l,b_fsm_l,b_l,b_raft_confReloadMu,b_raft_lastContactLock,b_raft_leaderLock,b_raft_observersLock,b_raft_shutdownLock,b_streamLayer_closeLock,child_Get11851);
	child_Get11851?0;
	stop_process: skip;
	child!0
}
proctype Transaction1247(Mutexdef b_autopilot_execLock;Mutexdef b_autopilot_stateLock;Mutexdef b_followerStates_l;Mutexdef b_fsm_l;Mutexdef b_l;Mutexdef b_raft_confReloadMu;Mutexdef b_raft_lastContactLock;Mutexdef b_raft_leaderLock;Mutexdef b_raft_observersLock;Mutexdef b_raft_shutdownLock;Mutexdef b_streamLayer_closeLock;int txns;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_applyLog12810 = [1] of {int};
	b_l.RLock!false;
	run applyLog1281(b_autopilot_execLock,b_autopilot_stateLock,b_followerStates_l,b_fsm_l,b_l,b_raft_confReloadMu,b_raft_lastContactLock,b_raft_leaderLock,b_raft_observersLock,b_raft_shutdownLock,b_streamLayer_closeLock,child_applyLog12810);
	child_applyLog12810?0;
	b_l.RUnlock!false;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype applyLog1281(Mutexdef b_autopilot_execLock;Mutexdef b_autopilot_stateLock;Mutexdef b_followerStates_l;Mutexdef b_fsm_l;Mutexdef b_l;Mutexdef b_raft_confReloadMu;Mutexdef b_raft_lastContactLock;Mutexdef b_raft_leaderLock;Mutexdef b_raft_observersLock;Mutexdef b_raft_shutdownLock;Mutexdef b_streamLayer_closeLock;chan child) {
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
proctype Get1185(Mutexdef b_autopilot_execLock;Mutexdef b_autopilot_stateLock;Mutexdef b_followerStates_l;Mutexdef b_fsm_l;Mutexdef b_l;Mutexdef b_raft_confReloadMu;Mutexdef b_raft_lastContactLock;Mutexdef b_raft_leaderLock;Mutexdef b_raft_observersLock;Mutexdef b_raft_shutdownLock;Mutexdef b_streamLayer_closeLock;chan child) {
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
	run Get436(b_fsm_l,child_Get4361);
	child_Get4361?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Get436(Mutexdef f_l;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	f_l.RLock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	f_l.RUnlock!false;
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

