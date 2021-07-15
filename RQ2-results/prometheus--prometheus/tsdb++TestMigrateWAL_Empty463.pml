
// https://github.com/prometheus/prometheus/blob/master/tsdb/wal_test.go#L463
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestMigrateWAL_Empty4630 = [1] of {int};
	run TestMigrateWAL_Empty463(child_TestMigrateWAL_Empty4630)
stop_process:skip
}

proctype TestMigrateWAL_Empty463(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close3270 = [1] of {int};
	Mutexdef w_mtx;
	run mutexMonitor(w_mtx);
	run Close327(w_mtx,child_Close3270);
	child_Close3270?0;
	stop_process: skip;
	child!0
}
proctype Close327(Mutexdef pb_mtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	pb_mtx.Lock!false;
	pb_mtx.Unlock!false;
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

