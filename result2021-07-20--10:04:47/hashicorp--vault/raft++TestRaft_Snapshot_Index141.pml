// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/vault/blob/f8f289712a3d37115090591602a2b92503fb3a13/physical/raft/snapshot_test.go#L141
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRaft_Snapshot_Index1410 = [1] of {int};
	run TestRaft_Snapshot_Index141(child_TestRaft_Snapshot_Index1410);
	run receiver(child_TestRaft_Snapshot_Index1410)
stop_process:skip
}

proctype TestRaft_Snapshot_Index141(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Put12117 = [1] of {int};
	chan child_Put12116 = [1] of {int};
	chan child_Snapshot7425 = [1] of {int};
	chan child_LatestState3924 = [1] of {int};
	chan child_Put12113 = [1] of {int};
	chan child_Put12112 = [1] of {int};
	chan child_LatestState3921 = [1] of {int};
	chan child_Put12110 = [1] of {int};
	Mutexdef raft_followerStates_l;
	Mutexdef raft_autopilot_execLock;
	Mutexdef raft_autopilot_stateLock;
	Mutexdef raft_streamLayer_closeLock;
	Mutexdef raft_raft_observersLock;
	Mutexdef raft_raft_shutdownLock;
	Mutexdef raft_raft_leaderLock;
	Mutexdef raft_raft_lastContactLock;
	Mutexdef raft_raft_confReloadMu;
	Mutexdef raft_fsm_l;
	Mutexdef raft_l;
	run mutexMonitor(raft_l);
	run mutexMonitor(raft_fsm_l);
	run mutexMonitor(raft_raft_confReloadMu);
	run mutexMonitor(raft_raft_lastContactLock);
	run mutexMonitor(raft_raft_leaderLock);
	run mutexMonitor(raft_raft_shutdownLock);
	run mutexMonitor(raft_raft_observersLock);
	run mutexMonitor(raft_streamLayer_closeLock);
	run mutexMonitor(raft_autopilot_stateLock);
	run mutexMonitor(raft_autopilot_execLock);
	run mutexMonitor(raft_followerStates_l);
	run Put1211(raft_autopilot_execLock,raft_autopilot_stateLock,raft_followerStates_l,raft_fsm_l,raft_l,raft_raft_confReloadMu,raft_raft_lastContactLock,raft_raft_leaderLock,raft_raft_observersLock,raft_raft_shutdownLock,raft_streamLayer_closeLock,child_Put12110);
	child_Put12110?0;
	run LatestState392(raft_fsm_l,child_LatestState3921);
	child_LatestState3921?0;
	

	if
	:: 0 != -2 && 100-1 != -3 -> 
				for(i : 0.. 100-1) {
			for11: skip;
			run Put1211(raft_autopilot_execLock,raft_autopilot_stateLock,raft_followerStates_l,raft_fsm_l,raft_l,raft_raft_confReloadMu,raft_raft_lastContactLock,raft_raft_leaderLock,raft_raft_observersLock,raft_raft_shutdownLock,raft_streamLayer_closeLock,child_Put12113);
			child_Put12113?0;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run Put1211(raft_autopilot_execLock,raft_autopilot_stateLock,raft_followerStates_l,raft_fsm_l,raft_l,raft_raft_confReloadMu,raft_raft_lastContactLock,raft_raft_leaderLock,raft_raft_observersLock,raft_raft_shutdownLock,raft_streamLayer_closeLock,child_Put12112);
			child_Put12112?0;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	run LatestState392(raft_fsm_l,child_LatestState3924);
	child_LatestState3924?0;
	run Snapshot742(raft_raft_confReloadMu,raft_raft_lastContactLock,raft_raft_leaderLock,raft_raft_observersLock,raft_raft_shutdownLock,child_Snapshot7425);
	child_Snapshot7425?0;
	

	if
	:: 0 != -2 && 100-1 != -3 -> 
				for(i : 0.. 100-1) {
			for21: skip;
			run Put1211(raft_autopilot_execLock,raft_autopilot_stateLock,raft_followerStates_l,raft_fsm_l,raft_l,raft_raft_confReloadMu,raft_raft_lastContactLock,raft_raft_leaderLock,raft_raft_observersLock,raft_raft_shutdownLock,raft_streamLayer_closeLock,child_Put12117);
			child_Put12117?0;
			for21_end: skip
		};
		for21_exit: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			run Put1211(raft_autopilot_execLock,raft_autopilot_stateLock,raft_followerStates_l,raft_fsm_l,raft_l,raft_raft_confReloadMu,raft_raft_lastContactLock,raft_raft_leaderLock,raft_raft_observersLock,raft_raft_shutdownLock,raft_streamLayer_closeLock,child_Put12116);
			child_Put12116?0;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype Put1211(Mutexdef b_autopilot_execLock;Mutexdef b_autopilot_stateLock;Mutexdef b_followerStates_l;Mutexdef b_fsm_l;Mutexdef b_l;Mutexdef b_raft_confReloadMu;Mutexdef b_raft_lastContactLock;Mutexdef b_raft_leaderLock;Mutexdef b_raft_observersLock;Mutexdef b_raft_shutdownLock;Mutexdef b_streamLayer_closeLock;chan child) {
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
proctype LatestState392(Mutexdef f_l;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Snapshot742(Mutexdef f_confReloadMu;Mutexdef f_lastContactLock;Mutexdef f_leaderLock;Mutexdef f_observersLock;Mutexdef f_shutdownLock;chan child) {
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

