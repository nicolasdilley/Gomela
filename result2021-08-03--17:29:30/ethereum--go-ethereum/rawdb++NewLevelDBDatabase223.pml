// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/ethereum/go-ethereum/blob/b8040a430e34117f121c67e8deee4a5e889e8372/core/rawdb/database.go#L223
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
	chan child_NewLevelDBDatabase2230 = [1] of {int};
	run NewLevelDBDatabase223(child_NewLevelDBDatabase2230);
	run receiver(child_NewLevelDBDatabase2230)
stop_process:skip
}

proctype NewLevelDBDatabase223(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewDatabase1190 = [1] of {int};
	Mutexdef db_quitLock;
	Wgdef db_db_closeW;
	Mutexdef db_db_compCommitLk;
	Mutexdef db_db_snapsMu;
	Mutexdef db_db_memMu;
	run mutexMonitor(db_db_memMu);
	run mutexMonitor(db_db_snapsMu);
	run mutexMonitor(db_db_compCommitLk);
	run wgMonitor(db_db_closeW);
	run mutexMonitor(db_quitLock);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run NewDatabase119(db_db_closeW,db_db_compCommitLk,db_db_memMu,db_db_snapsMu,db_quitLock,child_NewDatabase1190);
	child_NewDatabase1190?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype NewDatabase119(Wgdef db_db_closeW;Mutexdef db_db_compCommitLk;Mutexdef db_db_memMu;Mutexdef db_db_snapsMu;Mutexdef db_quitLock;chan child) {
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

