// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/pingcap/tidb/blob//table/column.go#L567
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_getColDefaultValueFromNil5670 = [1] of {int};
	run getColDefaultValueFromNil567(child_getColDefaultValueFromNil5670);
	run receiver(child_getColDefaultValueFromNil5670)
stop_process:skip
}

proctype getColDefaultValueFromNil567(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AppendWarning4271 = [1] of {int};
	chan child_AppendWarning4270 = [1] of {int};
	Mutexdef sc_digestMemo_m;
	Mutexdef sc_RuntimeStatsColl_mu;
	Mutexdef sc_DiskTracker_parMu;
	Mutexdef sc_DiskTracker_actionMu;
	Mutexdef sc_DiskTracker_mu;
	Mutexdef sc_MemTracker_parMu;
	Mutexdef sc_MemTracker_actionMu;
	Mutexdef sc_MemTracker_mu;
	Mutexdef sc_mu;
	Mutexdef vars_SequenceState_mu;
	Mutexdef vars_StmtCtx_digestMemo_m;
	Mutexdef vars_StmtCtx_RuntimeStatsColl_mu;
	Mutexdef vars_StmtCtx_DiskTracker_parMu;
	Mutexdef vars_StmtCtx_DiskTracker_actionMu;
	Mutexdef vars_StmtCtx_DiskTracker_mu;
	Mutexdef vars_StmtCtx_MemTracker_parMu;
	Mutexdef vars_StmtCtx_MemTracker_actionMu;
	Mutexdef vars_StmtCtx_MemTracker_mu;
	Mutexdef vars_StmtCtx_mu;
	Mutexdef vars_BinlogClient_Security_mutex;
	Wgdef vars_BinlogClient_wg;
	Mutexdef vars_TxnCtx_tdmLock;
	Mutexdef vars_UsersLock;
	

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
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(vars_UsersLock);
	run mutexMonitor(vars_TxnCtx_tdmLock);
	run wgMonitor(vars_BinlogClient_wg);
	run mutexMonitor(vars_BinlogClient_Security_mutex);
	run mutexMonitor(vars_StmtCtx_mu);
	run mutexMonitor(vars_StmtCtx_MemTracker_mu);
	run mutexMonitor(vars_StmtCtx_MemTracker_actionMu);
	run mutexMonitor(vars_StmtCtx_MemTracker_parMu);
	run mutexMonitor(vars_StmtCtx_DiskTracker_mu);
	run mutexMonitor(vars_StmtCtx_DiskTracker_actionMu);
	run mutexMonitor(vars_StmtCtx_DiskTracker_parMu);
	run mutexMonitor(vars_StmtCtx_RuntimeStatsColl_mu);
	run mutexMonitor(vars_StmtCtx_digestMemo_m);
	run mutexMonitor(vars_SequenceState_mu);
	run mutexMonitor(sc_mu);
	run mutexMonitor(sc_MemTracker_mu);
	run mutexMonitor(sc_MemTracker_actionMu);
	run mutexMonitor(sc_MemTracker_parMu);
	run mutexMonitor(sc_DiskTracker_mu);
	run mutexMonitor(sc_DiskTracker_actionMu);
	run mutexMonitor(sc_DiskTracker_parMu);
	run mutexMonitor(sc_RuntimeStatsColl_mu);
	run mutexMonitor(sc_digestMemo_m);
	

	if
	:: true -> 
		run AppendWarning427(sc_DiskTracker_actionMu,sc_DiskTracker_mu,sc_DiskTracker_parMu,sc_digestMemo_m,sc_MemTracker_actionMu,sc_MemTracker_mu,sc_MemTracker_parMu,sc_mu,sc_RuntimeStatsColl_mu,child_AppendWarning4270);
		child_AppendWarning4270?0;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run AppendWarning427(sc_DiskTracker_actionMu,sc_DiskTracker_mu,sc_DiskTracker_parMu,sc_digestMemo_m,sc_MemTracker_actionMu,sc_MemTracker_mu,sc_MemTracker_parMu,sc_mu,sc_RuntimeStatsColl_mu,child_AppendWarning4271);
		child_AppendWarning4271?0;
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AppendWarning427(Mutexdef sc_DiskTracker_actionMu;Mutexdef sc_DiskTracker_mu;Mutexdef sc_DiskTracker_parMu;Mutexdef sc_digestMemo_m;Mutexdef sc_MemTracker_actionMu;Mutexdef sc_MemTracker_mu;Mutexdef sc_MemTracker_parMu;Mutexdef sc_mu;Mutexdef sc_RuntimeStatsColl_mu;chan child) {
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
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

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

