#define exprToColumn80  -2

// https://github.com/pingcap/tidb/blob/master/planner/core/rule_generate_column_substitute.go#L80
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_substitute800 = [1] of {int};
	run substitute80(exprToColumn80,child_substitute800)
stop_process:skip
}

proctype substitute80(int exprToColumn;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef sctx_digestMemo_m;
	Mutexdef sctx_RuntimeStatsColl_mu;
	Mutexdef sctx_DiskTracker_parMu;
	Mutexdef sctx_DiskTracker_actionMu;
	Mutexdef sctx_DiskTracker_mu;
	Mutexdef sctx_MemTracker_parMu;
	Mutexdef sctx_MemTracker_actionMu;
	Mutexdef sctx_MemTracker_mu;
	Mutexdef sctx_mu_LockKeysDetail_Mu;
	Mutexdef sctx_mu_CommitDetail_Mu;
	Mutexdef sctx_mu_execDetails_LockKeysDetail_Mu;
	Mutexdef sctx_mu_execDetails_CommitDetail_Mu;
	run mutexMonitor(sctx_mu_execDetails_CommitDetail_Mu);
	run mutexMonitor(sctx_mu_execDetails_LockKeysDetail_Mu);
	run mutexMonitor(sctx_mu_CommitDetail_Mu);
	run mutexMonitor(sctx_mu_LockKeysDetail_Mu);
	run mutexMonitor(sctx_MemTracker_mu);
	run mutexMonitor(sctx_MemTracker_actionMu);
	run mutexMonitor(sctx_MemTracker_parMu);
	run mutexMonitor(sctx_DiskTracker_mu);
	run mutexMonitor(sctx_DiskTracker_actionMu);
	run mutexMonitor(sctx_DiskTracker_parMu);
	run mutexMonitor(sctx_RuntimeStatsColl_mu);
	run mutexMonitor(sctx_digestMemo_m);
	

	if
	:: true;
	:: true;
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

