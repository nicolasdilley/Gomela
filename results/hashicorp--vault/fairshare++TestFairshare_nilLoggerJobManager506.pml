
// https://github.com/hashicorp/vault/blob/master/helper/fairshare/jobmanager_test.go#L506
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
	chan child_TestFairshare_nilLoggerJobManager5060 = [1] of {int};
	run TestFairshare_nilLoggerJobManager506(child_TestFairshare_nilLoggerJobManager5060)
stop_process:skip
}

proctype TestFairshare_nilLoggerJobManager506(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef j_l;
	Wgdef j_wg;
	Mutexdef j_onceStop_m;
	Mutexdef j_onceStart_m;
	Wgdef j_workerPool_wg;
	Mutexdef j_workerPool_onceStop_m;
	Mutexdef j_workerPool_onceStart_m;
	run mutexMonitor(j_workerPool_onceStart_m);
	run mutexMonitor(j_workerPool_onceStop_m);
	run wgMonitor(j_workerPool_wg);
	run mutexMonitor(j_onceStart_m);
	run mutexMonitor(j_onceStop_m);
	run wgMonitor(j_wg);
	run mutexMonitor(j_l);
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

