
// https://github.com/pingcap/tidb/blob/master/executor/adapter.go#L854
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_CloseRecordSet8540 = [1] of {int};
	run CloseRecordSet854(child_CloseRecordSet8540)
stop_process:skip
}

proctype CloseRecordSet854(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef stmtCtx_digestMemo_m;
	Mutexdef stmtCtx_RuntimeStatsColl_mu;
	Mutexdef stmtCtx_DiskTracker_parMu;
	Mutexdef stmtCtx_DiskTracker_actionMu;
	Mutexdef stmtCtx_DiskTracker_mu;
	Mutexdef stmtCtx_MemTracker_parMu;
	Mutexdef stmtCtx_MemTracker_actionMu;
	Mutexdef stmtCtx_MemTracker_mu;
	Mutexdef stmtCtx_mu_LockKeysDetail_Mu;
	Mutexdef stmtCtx_mu_CommitDetail_Mu;
	Mutexdef stmtCtx_mu_execDetails_LockKeysDetail_Mu;
	Mutexdef stmtCtx_mu_execDetails_CommitDetail_Mu;
	run mutexMonitor(stmtCtx_mu_execDetails_CommitDetail_Mu);
	run mutexMonitor(stmtCtx_mu_execDetails_LockKeysDetail_Mu);
	run mutexMonitor(stmtCtx_mu_CommitDetail_Mu);
	run mutexMonitor(stmtCtx_mu_LockKeysDetail_Mu);
	run mutexMonitor(stmtCtx_MemTracker_mu);
	run mutexMonitor(stmtCtx_MemTracker_actionMu);
	run mutexMonitor(stmtCtx_MemTracker_parMu);
	run mutexMonitor(stmtCtx_DiskTracker_mu);
	run mutexMonitor(stmtCtx_DiskTracker_actionMu);
	run mutexMonitor(stmtCtx_DiskTracker_parMu);
	run mutexMonitor(stmtCtx_RuntimeStatsColl_mu);
	run mutexMonitor(stmtCtx_digestMemo_m);
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

