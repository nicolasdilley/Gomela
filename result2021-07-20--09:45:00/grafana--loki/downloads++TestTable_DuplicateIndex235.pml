// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/grafana/loki/blob/aa544a9dffdb8e78f7d7ed8edafce466d333b0a8/pkg/storage/stores/shipper/downloads/table_test.go#L235
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
	chan child_TestTable_DuplicateIndex2350 = [1] of {int};
	run TestTable_DuplicateIndex235(child_TestTable_DuplicateIndex2350);
	run receiver(child_TestTable_DuplicateIndex2350)
stop_process:skip
}

proctype TestTable_DuplicateIndex235(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_TestSingleTableQuery470 = [1] of {int};
	Wgdef __wait;
	Mutexdef __dbsMtx;
	Mutexdef table_dbsMtx;
	run mutexMonitor(table_dbsMtx);
	run mutexMonitor(__dbsMtx);
	run wgMonitor(__wait);
	run TestSingleTableQuery47(table_dbsMtx,child_TestSingleTableQuery470);
	child_TestSingleTableQuery470?0;
	stop_process: skip;
	child!0
}
proctype TestSingleTableQuery47(Mutexdef querier_dbsMtx;chan child) {
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

