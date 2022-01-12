// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/pingcap/tidb/blob//planner/core/planbuilder.go#L2211
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_buildSimple22110 = [1] of {int};
	run buildSimple2211(child_buildSimple22110);
	run receiver(child_buildSimple22110)
stop_process:skip
}

proctype buildSimple2211(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef pi_StmtCtx_digestMemo_m;
	Mutexdef pi_StmtCtx_RuntimeStatsColl_mu;
	Mutexdef pi_StmtCtx_DiskTracker_parMu;
	Mutexdef pi_StmtCtx_DiskTracker_actionMu;
	Mutexdef pi_StmtCtx_DiskTracker_mu;
	Mutexdef pi_StmtCtx_MemTracker_parMu;
	Mutexdef pi_StmtCtx_MemTracker_actionMu;
	Mutexdef pi_StmtCtx_MemTracker_mu;
	Mutexdef pi_StmtCtx_mu;
	Mutexdef pi_RuntimeStatsColl_mu;
	

	if
	:: true;
	:: true;
	:: true;
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi
	:: true;
	:: true;
	:: true;
	:: true -> 
		

		if
		:: true -> 
			run mutexMonitor(pi_RuntimeStatsColl_mu);
			run mutexMonitor(pi_StmtCtx_mu);
			run mutexMonitor(pi_StmtCtx_MemTracker_mu);
			run mutexMonitor(pi_StmtCtx_MemTracker_actionMu);
			run mutexMonitor(pi_StmtCtx_MemTracker_parMu);
			run mutexMonitor(pi_StmtCtx_DiskTracker_mu);
			run mutexMonitor(pi_StmtCtx_DiskTracker_actionMu);
			run mutexMonitor(pi_StmtCtx_DiskTracker_parMu);
			run mutexMonitor(pi_StmtCtx_RuntimeStatsColl_mu);
			run mutexMonitor(pi_StmtCtx_digestMemo_m)
		:: true;
		fi
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

