// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//core/ledger/kvledger/bookkeeping/provider.go#L33
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
	chan child_NewProvider330 = [1] of {int};
	run NewProvider33(child_NewProvider330);
	run receiver(child_NewProvider330)
stop_process:skip
}

proctype NewProvider33(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef dbProvider_mux;
	Mutexdef dbProvider_db_mutex;
	Wgdef dbProvider_db_db_closeW;
	Mutexdef dbProvider_db_db_compStats_lk;
	Mutexdef dbProvider_db_db_compCommitLk;
	Mutexdef dbProvider_db_db_tr_lk;
	Mutexdef dbProvider_db_db_snapsMu;
	Mutexdef dbProvider_db_db_memMu;
	Mutexdef dbProvider_db_db_s_vmu;
	Wgdef dbProvider_db_db_s_closeW;
	run wgMonitor(dbProvider_db_db_s_closeW);
	run mutexMonitor(dbProvider_db_db_s_vmu);
	run mutexMonitor(dbProvider_db_db_memMu);
	run mutexMonitor(dbProvider_db_db_snapsMu);
	run mutexMonitor(dbProvider_db_db_tr_lk);
	run mutexMonitor(dbProvider_db_db_compCommitLk);
	run mutexMonitor(dbProvider_db_db_compStats_lk);
	run wgMonitor(dbProvider_db_db_closeW);
	run mutexMonitor(dbProvider_db_mutex);
	run mutexMonitor(dbProvider_mux);
	

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

