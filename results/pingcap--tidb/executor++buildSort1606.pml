
// https://github.com/pingcap/tidb/blob/master/executor/builder.go#L1606
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_buildSort16060 = [1] of {int};
	run buildSort1606(child_buildSort16060)
stop_process:skip
}

proctype buildSort1606(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef sortExec_spillAction_c_ptrM;
	Mutexdef sortExec_diskTracker_parMu;
	Mutexdef sortExec_diskTracker_actionMu;
	Mutexdef sortExec_diskTracker_mu;
	Mutexdef sortExec_memTracker_parMu;
	Mutexdef sortExec_memTracker_actionMu;
	Mutexdef sortExec_memTracker_mu;
	Mutexdef sortExec_rowChunks_ptrM;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(sortExec_rowChunks_ptrM);
	run mutexMonitor(sortExec_memTracker_mu);
	run mutexMonitor(sortExec_memTracker_actionMu);
	run mutexMonitor(sortExec_memTracker_parMu);
	run mutexMonitor(sortExec_diskTracker_mu);
	run mutexMonitor(sortExec_diskTracker_actionMu);
	run mutexMonitor(sortExec_diskTracker_parMu);
	run mutexMonitor(sortExec_spillAction_c_ptrM);
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

