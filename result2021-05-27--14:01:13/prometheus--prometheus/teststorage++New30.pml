// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/prometheus/prometheus/blob/27b78c336e436e9eed8b55ab0b162b888ec641d8/util/teststorage/storage.go#L30
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_New300 = [1] of {int};
	run New30(child_New300);
	run receiver(child_New300)
stop_process:skip
}

proctype New30(chan child) {
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

