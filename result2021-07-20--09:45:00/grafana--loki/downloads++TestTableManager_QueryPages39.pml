// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/grafana/loki/blob/aa544a9dffdb8e78f7d7ed8edafce466d333b0a8/pkg/storage/stores/shipper/downloads/table_manager_test.go#L39
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
	chan child_TestTableManager_QueryPages390 = [1] of {int};
	run TestTableManager_QueryPages39(child_TestTableManager_QueryPages390);
	run receiver(child_TestTableManager_QueryPages390)
stop_process:skip
}

proctype TestTableManager_QueryPages39(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_TestMultiTableQuery770 = [1] of {int};
	Wgdef tableManager_wg;
	Mutexdef tableManager_tablesMtx;
	int var_tablestables = -2; // opt var_tablestables
	run mutexMonitor(tableManager_tablesMtx);
	run wgMonitor(tableManager_wg);
	run TestMultiTableQuery77(tableManager_wg,tableManager_tablesMtx,child_TestMultiTableQuery770);
	child_TestMultiTableQuery770?0;
	stop_process: skip;
	child!0
}
proctype TestMultiTableQuery77(Wgdef querier_wg;Mutexdef querier_tablesMtx;chan child) {
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

