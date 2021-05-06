
// https://github.com/pingcap/tidb/blob/master/planner/core/handle_cols.go#L262
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_GetCommonHandleDatum2620 = [1] of {int};
	run GetCommonHandleDatum262(child_GetCommonHandleDatum2620)
stop_process:skip
}

proctype GetCommonHandleDatum262(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef cb_sc_digestMemo_m;
	Mutexdef cb_sc_RuntimeStatsColl_mu;
	Mutexdef cb_sc_DiskTracker_parMu;
	Mutexdef cb_sc_DiskTracker_actionMu;
	Mutexdef cb_sc_DiskTracker_mu;
	Mutexdef cb_sc_MemTracker_parMu;
	Mutexdef cb_sc_MemTracker_actionMu;
	Mutexdef cb_sc_MemTracker_mu;
	Mutexdef cb_sc_mu_LockKeysDetail_Mu;
	Mutexdef cb_sc_mu_CommitDetail_Mu;
	Mutexdef cb_sc_mu_execDetails_LockKeysDetail_Mu;
	Mutexdef cb_sc_mu_execDetails_CommitDetail_Mu;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(cb_sc_mu_execDetails_CommitDetail_Mu);
	run mutexMonitor(cb_sc_mu_execDetails_LockKeysDetail_Mu);
	run mutexMonitor(cb_sc_mu_CommitDetail_Mu);
	run mutexMonitor(cb_sc_mu_LockKeysDetail_Mu);
	run mutexMonitor(cb_sc_MemTracker_mu);
	run mutexMonitor(cb_sc_MemTracker_actionMu);
	run mutexMonitor(cb_sc_MemTracker_parMu);
	run mutexMonitor(cb_sc_DiskTracker_mu);
	run mutexMonitor(cb_sc_DiskTracker_actionMu);
	run mutexMonitor(cb_sc_DiskTracker_parMu);
	run mutexMonitor(cb_sc_RuntimeStatsColl_mu);
	run mutexMonitor(cb_sc_digestMemo_m);
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

