#define not_found_779  -2

// https://github.com/ethereum/go-ethereum/blob/master/core/state/state_test.go#L145
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestSnapshotEmpty1450 = [1] of {int};
	run TestSnapshotEmpty145(child_TestSnapshotEmpty1450)
stop_process:skip
}

proctype TestSnapshotEmpty145(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_RevertToSnapshot7680 = [1] of {int};
	Mutexdef s_state_snaps_lock;
	Mutexdef s_state_snaps_triedb_lock;
	run mutexMonitor(s_state_snaps_triedb_lock);
	run mutexMonitor(s_state_snaps_lock);
	run RevertToSnapshot768(s_state_snaps_triedb_lock,s_state_snaps_lock,child_RevertToSnapshot7680);
	child_RevertToSnapshot7680?0;
	stop_process: skip;
	child!0
}
proctype RevertToSnapshot768(Mutexdef s_snaps_triedb_lock;Mutexdef s_snaps_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_revert600 = [1] of {int};
	run revert60(s_snaps_triedb_lock,s_snaps_lock,not_found_779,child_revert600);
	child_revert600?0;
	stop_process: skip;
	child!0
}
proctype revert60(Mutexdef statedb_snaps_triedb_lock;Mutexdef statedb_snaps_lock;int snapshot;chan child) {
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

