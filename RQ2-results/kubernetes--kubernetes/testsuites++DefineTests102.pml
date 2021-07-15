
// https://github.com/kubernetes/kubernetes/blob/master/test/e2e/storage/testsuites/snapshottable.go#L102
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
	chan child_DefineTests1020 = [1] of {int};
	run DefineTests102(child_DefineTests1020)
stop_process:skip
}

proctype DefineTests102(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef f_flakeReport_lock;
	Wgdef f_logsSizeVerifier_wg;
	Mutexdef f_logsSizeVerifier_data_lock;
	Wgdef f_logsSizeWaitGroup;
	Wgdef f_gatherer_workerWg;
	run wgMonitor(f_gatherer_workerWg);
	run wgMonitor(f_logsSizeWaitGroup);
	run mutexMonitor(f_logsSizeVerifier_data_lock);
	run wgMonitor(f_logsSizeVerifier_wg);
	run mutexMonitor(f_flakeReport_lock);
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

