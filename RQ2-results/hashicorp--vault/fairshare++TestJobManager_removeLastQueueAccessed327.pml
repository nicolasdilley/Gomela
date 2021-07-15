
// https://github.com/hashicorp/vault/blob/master/helper/fairshare/jobmanager_test.go#L327
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
	chan child_TestJobManager_removeLastQueueAccessed3270 = [1] of {int};
	run TestJobManager_removeLastQueueAccessed327(child_TestJobManager_removeLastQueueAccessed3270)
stop_process:skip
}

proctype TestJobManager_removeLastQueueAccessed327(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_removeLastQueueAccessed2393 = [1] of {int};
	chan child_removeLastQueueAccessed2394 = [1] of {int};
	chan child_addQueue2292 = [1] of {int};
	chan child_addQueue2291 = [1] of {int};
	chan child_addQueue2290 = [1] of {int};
	Mutexdef j_l;
	Wgdef j_wg;
	Mutexdef j_onceStop_m;
	Mutexdef j_onceStart_m;
	Wgdef j_workerPool_wg;
	Mutexdef j_workerPool_onceStop_m;
	Mutexdef j_workerPool_onceStart_m;
	int testCases = -2;
	run mutexMonitor(j_workerPool_onceStart_m);
	run mutexMonitor(j_workerPool_onceStop_m);
	run wgMonitor(j_workerPool_wg);
	run mutexMonitor(j_onceStart_m);
	run mutexMonitor(j_onceStop_m);
	run wgMonitor(j_wg);
	run mutexMonitor(j_l);
	run addQueue229(j_workerPool_wg,j_wg,j_workerPool_onceStart_m,j_workerPool_onceStop_m,j_onceStart_m,j_onceStop_m,j_l,child_addQueue2290);
	child_addQueue2290?0;
	run addQueue229(j_workerPool_wg,j_wg,j_workerPool_onceStart_m,j_workerPool_onceStop_m,j_onceStart_m,j_onceStop_m,j_l,child_addQueue2291);
	child_addQueue2291?0;
	run addQueue229(j_workerPool_wg,j_wg,j_workerPool_onceStart_m,j_workerPool_onceStop_m,j_onceStart_m,j_onceStop_m,j_l,child_addQueue2292);
	child_addQueue2292?0;
	j_l.Lock!false;
	

	if
	:: testCases-1 != -3 -> 
				for(i : 0.. testCases-1) {
			for10: skip;
			run removeLastQueueAccessed239(j_workerPool_wg,j_wg,j_workerPool_onceStart_m,j_workerPool_onceStop_m,j_onceStart_m,j_onceStop_m,j_l,child_removeLastQueueAccessed2393);
			child_removeLastQueueAccessed2393?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for13: skip;
			run removeLastQueueAccessed239(j_workerPool_wg,j_wg,j_workerPool_onceStart_m,j_workerPool_onceStop_m,j_onceStart_m,j_onceStop_m,j_l,child_removeLastQueueAccessed2394);
			child_removeLastQueueAccessed2394?0;
			for13_end: skip
		:: true -> 
			break
		od;
		for13_exit: skip
	fi;
	stop_process: skip;
		j_l.Unlock!false;
	child!0
}
proctype addQueue229(Wgdef j_workerPool_wg;Wgdef j_wg;Mutexdef j_workerPool_onceStart_m;Mutexdef j_workerPool_onceStop_m;Mutexdef j_onceStart_m;Mutexdef j_onceStop_m;Mutexdef j_l;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype removeLastQueueAccessed239(Wgdef j_workerPool_wg;Wgdef j_wg;Mutexdef j_workerPool_onceStart_m;Mutexdef j_workerPool_onceStop_m;Mutexdef j_onceStart_m;Mutexdef j_onceStop_m;Mutexdef j_l;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

