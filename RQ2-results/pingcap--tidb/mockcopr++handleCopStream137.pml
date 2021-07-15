
// https://github.com/pingcap/tidb/blob/master/store/mockstore/mockcopr/cop_handler_dag.go#L137
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_handleCopStream1370 = [1] of {int};
	run handleCopStream137(child_handleCopStream1370)
stop_process:skip
}

proctype handleCopStream137(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef dagCtx_evalCtx_sc_digestMemo_m;
	Mutexdef dagCtx_evalCtx_sc_RuntimeStatsColl_mu;
	Mutexdef dagCtx_evalCtx_sc_DiskTracker_parMu;
	Mutexdef dagCtx_evalCtx_sc_DiskTracker_actionMu;
	Mutexdef dagCtx_evalCtx_sc_DiskTracker_mu;
	Mutexdef dagCtx_evalCtx_sc_MemTracker_parMu;
	Mutexdef dagCtx_evalCtx_sc_MemTracker_actionMu;
	Mutexdef dagCtx_evalCtx_sc_MemTracker_mu;
	Mutexdef dagCtx_evalCtx_sc_mu_LockKeysDetail_Mu;
	Mutexdef dagCtx_evalCtx_sc_mu_CommitDetail_Mu;
	Mutexdef dagCtx_evalCtx_sc_mu_execDetails_LockKeysDetail_Mu;
	Mutexdef dagCtx_evalCtx_sc_mu_execDetails_CommitDetail_Mu;
	run mutexMonitor(dagCtx_evalCtx_sc_mu_execDetails_CommitDetail_Mu);
	run mutexMonitor(dagCtx_evalCtx_sc_mu_execDetails_LockKeysDetail_Mu);
	run mutexMonitor(dagCtx_evalCtx_sc_mu_CommitDetail_Mu);
	run mutexMonitor(dagCtx_evalCtx_sc_mu_LockKeysDetail_Mu);
	run mutexMonitor(dagCtx_evalCtx_sc_MemTracker_mu);
	run mutexMonitor(dagCtx_evalCtx_sc_MemTracker_actionMu);
	run mutexMonitor(dagCtx_evalCtx_sc_MemTracker_parMu);
	run mutexMonitor(dagCtx_evalCtx_sc_DiskTracker_mu);
	run mutexMonitor(dagCtx_evalCtx_sc_DiskTracker_actionMu);
	run mutexMonitor(dagCtx_evalCtx_sc_DiskTracker_parMu);
	run mutexMonitor(dagCtx_evalCtx_sc_RuntimeStatsColl_mu);
	run mutexMonitor(dagCtx_evalCtx_sc_digestMemo_m);
	

	if
	:: true -> 
		goto stop_process
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

