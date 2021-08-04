// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/vault/blob/f8f289712a3d37115090591602a2b92503fb3a13/physical/raft/snapshot_test.go#L57
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRaft_Snapshot_Loading570 = [1] of {int};
	run TestRaft_Snapshot_Loading57(child_TestRaft_Snapshot_Loading570);
	run receiver(child_TestRaft_Snapshot_Loading570)
stop_process:skip
}

proctype TestRaft_Snapshot_Loading57(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestRaft_Snapshot_Loading75582 = [1] of {int};
	Mutexdef metaWriteCloser_p_wrMu;
	Mutexdef metaReadCloser_p_wrMu;
	Mutexdef writeCloser_p_wrMu;
	Mutexdef readCloser_p_wrMu;
	chan child_Put11781 = [1] of {int};
	chan child_Put11780 = [1] of {int};
	Mutexdef raft_followerStates_l;
	Mutexdef raft_autopilot_execLock;
	Mutexdef raft_autopilot_stateLock;
	Mutexdef raft_streamLayer_closeLock;
	Mutexdef raft_raft_observersLock;
	Mutexdef raft_raft_shutdownLock;
	Mutexdef raft_raft_leaderLock;
	Mutexdef raft_raft_lastContactLock;
	Mutexdef raft_fsm_l;
	Mutexdef raft_l;
	run mutexMonitor(raft_l);
	run mutexMonitor(raft_fsm_l);
	run mutexMonitor(raft_raft_lastContactLock);
	run mutexMonitor(raft_raft_leaderLock);
	run mutexMonitor(raft_raft_shutdownLock);
	run mutexMonitor(raft_raft_observersLock);
	run mutexMonitor(raft_streamLayer_closeLock);
	run mutexMonitor(raft_autopilot_stateLock);
	run mutexMonitor(raft_autopilot_execLock);
	run mutexMonitor(raft_followerStates_l);
	

	if
	:: 0 != -2 && 1000-1 != -3 -> 
				for(i : 0.. 1000-1) {
			for11: skip;
			run Put1178(raft_autopilot_execLock,raft_autopilot_stateLock,raft_followerStates_l,raft_fsm_l,raft_l,raft_raft_lastContactLock,raft_raft_leaderLock,raft_raft_observersLock,raft_raft_shutdownLock,raft_streamLayer_closeLock,child_Put11781);
			child_Put11781?0;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run Put1178(raft_autopilot_execLock,raft_autopilot_stateLock,raft_followerStates_l,raft_fsm_l,raft_l,raft_raft_lastContactLock,raft_raft_leaderLock,raft_raft_observersLock,raft_raft_shutdownLock,raft_streamLayer_closeLock,child_Put11780);
			child_Put11780?0;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	run mutexMonitor(readCloser_p_wrMu);
	run mutexMonitor(writeCloser_p_wrMu);
	run mutexMonitor(metaReadCloser_p_wrMu);
	run mutexMonitor(metaWriteCloser_p_wrMu);
	run AnonymousTestRaft_Snapshot_Loading7558(raft_l,raft_fsm_l,raft_raft_lastContactLock,raft_raft_leaderLock,raft_raft_shutdownLock,raft_raft_observersLock,raft_streamLayer_closeLock,raft_autopilot_stateLock,raft_autopilot_execLock,raft_followerStates_l,readCloser_p_wrMu,writeCloser_p_wrMu,metaReadCloser_p_wrMu,metaWriteCloser_p_wrMu,child_AnonymousTestRaft_Snapshot_Loading75582);
	run receiver(child_AnonymousTestRaft_Snapshot_Loading75582);
	stop_process: skip;
	child!0
}
proctype Put1178(Mutexdef b_autopilot_execLock;Mutexdef b_autopilot_stateLock;Mutexdef b_followerStates_l;Mutexdef b_fsm_l;Mutexdef b_l;Mutexdef b_raft_lastContactLock;Mutexdef b_raft_leaderLock;Mutexdef b_raft_observersLock;Mutexdef b_raft_shutdownLock;Mutexdef b_streamLayer_closeLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_applyLog12480 = [1] of {int};
	b_l.RLock!false;
	run applyLog1248(b_autopilot_execLock,b_autopilot_stateLock,b_followerStates_l,b_fsm_l,b_l,b_raft_lastContactLock,b_raft_leaderLock,b_raft_observersLock,b_raft_shutdownLock,b_streamLayer_closeLock,child_applyLog12480);
	child_applyLog12480?0;
	b_l.RUnlock!false;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype applyLog1248(Mutexdef b_autopilot_execLock;Mutexdef b_autopilot_stateLock;Mutexdef b_followerStates_l;Mutexdef b_fsm_l;Mutexdef b_l;Mutexdef b_raft_lastContactLock;Mutexdef b_raft_leaderLock;Mutexdef b_raft_observersLock;Mutexdef b_raft_shutdownLock;Mutexdef b_streamLayer_closeLock;chan child) {
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
proctype AnonymousTestRaft_Snapshot_Loading7558(Mutexdef raft_l;Mutexdef raft_fsm_l;Mutexdef raft_raft_lastContactLock;Mutexdef raft_raft_leaderLock;Mutexdef raft_raft_shutdownLock;Mutexdef raft_raft_observersLock;Mutexdef raft_streamLayer_closeLock;Mutexdef raft_autopilot_stateLock;Mutexdef raft_autopilot_execLock;Mutexdef raft_followerStates_l;Mutexdef readCloser_p_wrMu;Mutexdef writeCloser_p_wrMu;Mutexdef metaReadCloser_p_wrMu;Mutexdef metaWriteCloser_p_wrMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_writeTo6982 = [1] of {int};
	run writeTo698(raft_fsm_l,metaWriteCloser_p_wrMu,writeCloser_p_wrMu,child_writeTo6982);
	child_writeTo6982?0;
	stop_process: skip;
	child!0
}
proctype writeTo698(Mutexdef f_l;Mutexdef metaSink_p_wrMu;Mutexdef sink_p_wrMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewDelimitedWriter453 = [1] of {int};
	chan child_NewDelimitedWriter452 = [1] of {int};
	run NewDelimitedWriter45(sink_p_wrMu,child_NewDelimitedWriter452);
	child_NewDelimitedWriter452?0;
	run NewDelimitedWriter45(metaSink_p_wrMu,child_NewDelimitedWriter453);
	child_NewDelimitedWriter453?0;
	f_l.RLock!false;
		defer1: skip;
	f_l.RUnlock!false;
	stop_process: skip;
	child!0
}
proctype NewDelimitedWriter45(Mutexdef w_p_wrMu;chan child) {
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

