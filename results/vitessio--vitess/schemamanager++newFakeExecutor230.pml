// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/schemamanager/schemamanager_test.go#L230
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_newFakeExecutor2300 = [1] of {int};
	run newFakeExecutor230(child_newFakeExecutor2300);
	run receiver(child_newFakeExecutor2300)
stop_process:skip
}

proctype newFakeExecutor230(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewTabletExecutor490 = [1] of {int};
	Mutexdef wr_sourceTs_mu;
	Mutexdef wr_ts_mu;
	run mutexMonitor(wr_ts_mu);
	run mutexMonitor(wr_sourceTs_mu);
	run NewTabletExecutor49(wr_sourceTs_mu,wr_ts_mu,child_NewTabletExecutor490);
	child_NewTabletExecutor490?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype NewTabletExecutor49(Mutexdef wr_sourceTs_mu;Mutexdef wr_ts_mu;chan child) {
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

