// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/pingcap/tidb/blob//planner/core/handle_cols.go#L262
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_GetCommonHandleDatum2620 = [1] of {int};
	run GetCommonHandleDatum262(child_GetCommonHandleDatum2620);
	run receiver(child_GetCommonHandleDatum2620)
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
	Mutexdef cb_sc_mu;
	int var_cb_columns = -2; // opt var_cb_columns
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(cb_sc_mu);
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

proctype receiver(chan c) {
c?0
}

