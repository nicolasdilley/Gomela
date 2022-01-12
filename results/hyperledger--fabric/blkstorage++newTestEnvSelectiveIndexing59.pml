// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//common/ledger/blkstorage/pkg_test.go#L59
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
	chan child_newTestEnvSelectiveIndexing590 = [1] of {int};
	run newTestEnvSelectiveIndexing59(child_newTestEnvSelectiveIndexing590);
	run receiver(child_newTestEnvSelectiveIndexing590)
stop_process:skip
}

proctype newTestEnvSelectiveIndexing59(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef p_leveldbProvider_mux;
	Mutexdef p_leveldbProvider_db_mutex;
	Wgdef p_leveldbProvider_db_db_closeW;
	Mutexdef p_leveldbProvider_db_db_compCommitLk;
	Mutexdef p_leveldbProvider_db_db_snapsMu;
	Mutexdef p_leveldbProvider_db_db_memMu;
	run mutexMonitor(p_leveldbProvider_db_db_memMu);
	run mutexMonitor(p_leveldbProvider_db_db_snapsMu);
	run mutexMonitor(p_leveldbProvider_db_db_compCommitLk);
	run wgMonitor(p_leveldbProvider_db_db_closeW);
	run mutexMonitor(p_leveldbProvider_db_mutex);
	run mutexMonitor(p_leveldbProvider_mux);
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

