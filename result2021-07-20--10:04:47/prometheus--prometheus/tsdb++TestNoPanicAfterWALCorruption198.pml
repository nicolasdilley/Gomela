// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/prometheus/prometheus/blob/27b78c336e436e9eed8b55ab0b162b888ec641d8/tsdb/db_test.go#L198
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestNoPanicAfterWALCorruption1980 = [1] of {int};
	run TestNoPanicAfterWALCorruption198(child_TestNoPanicAfterWALCorruption1980);
	run receiver(child_TestNoPanicAfterWALCorruption1980)
stop_process:skip
}

proctype TestNoPanicAfterWALCorruption198(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef db_autoCompactMtx;
	Mutexdef db_cmtx;
	Mutexdef db_head_closedMtx;
	Mutexdef db_head_cardinalityMutex;
	Mutexdef db_head_deletedMtx;
	Mutexdef db_head_symMtx;
	Mutexdef db_mtx;
	run mutexMonitor(db_mtx);
	run mutexMonitor(db_head_symMtx);
	run mutexMonitor(db_head_deletedMtx);
	run mutexMonitor(db_head_cardinalityMutex);
	run mutexMonitor(db_head_closedMtx);
	run mutexMonitor(db_cmtx);
	run mutexMonitor(db_autoCompactMtx);
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

