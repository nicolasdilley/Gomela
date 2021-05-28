// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/vault/blob/f8f289712a3d37115090591602a2b92503fb3a13/physical/raft/chunking_test.go#L185
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRaft_Chunking_AppliedIndex1850 = [1] of {int};
	run TestRaft_Chunking_AppliedIndex185(child_TestRaft_Chunking_AppliedIndex1850);
	run receiver(child_TestRaft_Chunking_AppliedIndex1850)
stop_process:skip
}

proctype TestRaft_Chunking_AppliedIndex185(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Get11526 = [1] of {int};
	chan child_Get11525 = [1] of {int};
	chan child_AppliedIndex9014 = [1] of {int};
	chan child_Put11783 = [1] of {int};
	chan child_Put11782 = [1] of {int};
	chan child_AppliedIndex9011 = [1] of {int};
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
	run Put1178(raft_autopilot_execLock,raft_autopilot_stateLock,raft_followerStates_l,raft_fsm_l,raft_l,raft_raft_lastContactLock,raft_raft_leaderLock,raft_raft_observersLock,raft_raft_shutdownLock,raft_streamLayer_closeLock,child_Put11780);
	child_Put11780?0;
	run AppliedIndex901(raft_autopilot_execLock,raft_autopilot_stateLock,raft_followerStates_l,raft_fsm_l,raft_l,raft_raft_lastContactLock,raft_raft_leaderLock,raft_raft_observersLock,raft_raft_shutdownLock,raft_streamLayer_closeLock,child_AppliedIndex9011);
	child_AppliedIndex9011?0;
	

	if
	:: 0 != -2 && 10-1 != -3 -> 
				for(i : 0.. 10-1) {
			for11: skip;
			run Put1178(raft_autopilot_execLock,raft_autopilot_stateLock,raft_followerStates_l,raft_fsm_l,raft_l,raft_raft_lastContactLock,raft_raft_leaderLock,raft_raft_observersLock,raft_raft_shutdownLock,raft_streamLayer_closeLock,child_Put11783);
			child_Put11783?0;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run Put1178(raft_autopilot_execLock,raft_autopilot_stateLock,raft_followerStates_l,raft_fsm_l,raft_l,raft_raft_lastContactLock,raft_raft_leaderLock,raft_raft_observersLock,raft_raft_shutdownLock,raft_streamLayer_closeLock,child_Put11782);
			child_Put11782?0;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	run AppliedIndex901(raft_autopilot_execLock,raft_autopilot_stateLock,raft_followerStates_l,raft_fsm_l,raft_l,raft_raft_lastContactLock,raft_raft_leaderLock,raft_raft_observersLock,raft_raft_shutdownLock,raft_streamLayer_closeLock,child_AppliedIndex9014);
	child_AppliedIndex9014?0;
	

	if
	:: 0 != -2 && 10-1 != -3 -> 
				for(i : 0.. 10-1) {
			for21: skip;
			run Get1152(raft_autopilot_execLock,raft_autopilot_stateLock,raft_followerStates_l,raft_fsm_l,raft_l,raft_raft_lastContactLock,raft_raft_leaderLock,raft_raft_observersLock,raft_raft_shutdownLock,raft_streamLayer_closeLock,child_Get11526);
			child_Get11526?0;
			for21_end: skip
		};
		for21_exit: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			run Get1152(raft_autopilot_execLock,raft_autopilot_stateLock,raft_followerStates_l,raft_fsm_l,raft_l,raft_raft_lastContactLock,raft_raft_leaderLock,raft_raft_observersLock,raft_raft_shutdownLock,raft_streamLayer_closeLock,child_Get11525);
			child_Get11525?0;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
		stop_process: skip;
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
		stop_process: skip;
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
	stop_process: skip;
	child!0
}
proctype AppliedIndex901(Mutexdef b_autopilot_execLock;Mutexdef b_autopilot_stateLock;Mutexdef b_followerStates_l;Mutexdef b_fsm_l;Mutexdef b_l;Mutexdef b_raft_lastContactLock;Mutexdef b_raft_leaderLock;Mutexdef b_raft_observersLock;Mutexdef b_raft_shutdownLock;Mutexdef b_streamLayer_closeLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_LatestState3921 = [1] of {int};
	b_l.RLock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	run LatestState392(b_fsm_l,child_LatestState3921);
	child_LatestState3921?0;
	goto defer1;
		defer1: skip;
	b_l.RUnlock!false;
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
proctype Get1152(Mutexdef b_autopilot_execLock;Mutexdef b_autopilot_stateLock;Mutexdef b_followerStates_l;Mutexdef b_fsm_l;Mutexdef b_l;Mutexdef b_raft_lastContactLock;Mutexdef b_raft_leaderLock;Mutexdef b_raft_observersLock;Mutexdef b_raft_shutdownLock;Mutexdef b_streamLayer_closeLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Get4365 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Get436(b_fsm_l,child_Get4365);
	child_Get4365?0;
	goto stop_process;
		stop_process: skip;
		stop_process: skip;
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
		stop_process: skip;
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

