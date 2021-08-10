// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/syncthing/syncthing/blob/87a0eecc31a0a5eeef1d0da510f4d5832e022e1f/lib/db/backend/leveldb_open.go#L55
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
	chan child_OpenLevelDBRO550 = [1] of {int};
	run OpenLevelDBRO55(child_OpenLevelDBRO550);
	run receiver(child_OpenLevelDBRO550)
stop_process:skip
}

proctype OpenLevelDBRO55(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_newLeveldbBackend360 = [1] of {int};
	Wgdef ldb_closeW;
	Mutexdef ldb_compStats_lk;
	Mutexdef ldb_compCommitLk;
	Mutexdef ldb_tr_lk;
	Mutexdef ldb_snapsMu;
	Mutexdef ldb_memMu;
	Mutexdef ldb_s_vmu;
	Wgdef ldb_s_closeW;
	run wgMonitor(ldb_s_closeW);
	run mutexMonitor(ldb_s_vmu);
	run mutexMonitor(ldb_memMu);
	run mutexMonitor(ldb_snapsMu);
	run mutexMonitor(ldb_tr_lk);
	run mutexMonitor(ldb_compCommitLk);
	run mutexMonitor(ldb_compStats_lk);
	run wgMonitor(ldb_closeW);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run newLeveldbBackend36(ldb_closeW,ldb_s_closeW,ldb_compCommitLk,ldb_compStats_lk,ldb_memMu,ldb_s_vmu,ldb_snapsMu,ldb_tr_lk,child_newLeveldbBackend360);
	child_newLeveldbBackend360?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype newLeveldbBackend36(Wgdef ldb_closeW;Wgdef ldb_s_closeW;Mutexdef ldb_compCommitLk;Mutexdef ldb_compStats_lk;Mutexdef ldb_memMu;Mutexdef ldb_s_vmu;Mutexdef ldb_snapsMu;Mutexdef ldb_tr_lk;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
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

