// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/pingcap/tidb/blob//executor/coprocessor.go#L128
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_buildDAGExecutor1280 = [1] of {int};
	run buildDAGExecutor128(child_buildDAGExecutor1280);
	run receiver(child_buildDAGExecutor1280)
stop_process:skip
}

proctype buildDAGExecutor128(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SetFlagsFromPBFlag7050 = [1] of {int};
	Mutexdef stmtCtx_digestMemo_m;
	Mutexdef stmtCtx_RuntimeStatsColl_mu;
	Mutexdef stmtCtx_DiskTracker_parMu;
	Mutexdef stmtCtx_DiskTracker_actionMu;
	Mutexdef stmtCtx_DiskTracker_mu;
	Mutexdef stmtCtx_MemTracker_parMu;
	Mutexdef stmtCtx_MemTracker_actionMu;
	Mutexdef stmtCtx_MemTracker_mu;
	Mutexdef stmtCtx_mu;
	

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
	run mutexMonitor(stmtCtx_mu);
	run mutexMonitor(stmtCtx_MemTracker_mu);
	run mutexMonitor(stmtCtx_MemTracker_actionMu);
	run mutexMonitor(stmtCtx_MemTracker_parMu);
	run mutexMonitor(stmtCtx_DiskTracker_mu);
	run mutexMonitor(stmtCtx_DiskTracker_actionMu);
	run mutexMonitor(stmtCtx_DiskTracker_parMu);
	run mutexMonitor(stmtCtx_RuntimeStatsColl_mu);
	run mutexMonitor(stmtCtx_digestMemo_m);
	run SetFlagsFromPBFlag705(stmtCtx_DiskTracker_actionMu,stmtCtx_DiskTracker_mu,stmtCtx_DiskTracker_parMu,stmtCtx_digestMemo_m,stmtCtx_MemTracker_actionMu,stmtCtx_MemTracker_mu,stmtCtx_MemTracker_parMu,stmtCtx_mu,stmtCtx_RuntimeStatsColl_mu,child_SetFlagsFromPBFlag7050);
	child_SetFlagsFromPBFlag7050?0;
	

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
	child!0
}
proctype SetFlagsFromPBFlag705(Mutexdef sc_DiskTracker_actionMu;Mutexdef sc_DiskTracker_mu;Mutexdef sc_DiskTracker_parMu;Mutexdef sc_digestMemo_m;Mutexdef sc_MemTracker_actionMu;Mutexdef sc_MemTracker_mu;Mutexdef sc_MemTracker_parMu;Mutexdef sc_mu;Mutexdef sc_RuntimeStatsColl_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

