
// https://github.com/prometheus/prometheus/blob/master/tsdb/block_test.go#L59
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
	chan child_TestSetCompactionFailed590 = [1] of {int};
	run TestSetCompactionFailed59(child_TestSetCompactionFailed590)
stop_process:skip
}

proctype TestSetCompactionFailed59(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close3272 = [1] of {int};
	chan child_Close3271 = [1] of {int};
	chan child_setCompactionFailed4050 = [1] of {int};
	Wgdef b_pendingReaders;
	Mutexdef b_mtx;
	run mutexMonitor(b_mtx);
	run wgMonitor(b_pendingReaders);
	run setCompactionFailed405(b_pendingReaders,b_mtx,child_setCompactionFailed4050);
	child_setCompactionFailed4050?0;
	run Close327(b_pendingReaders,b_mtx,child_Close3271);
	child_Close3271?0;
	run Close327(b_pendingReaders,b_mtx,child_Close3272);
	child_Close3272?0;
	stop_process: skip;
	child!0
}
proctype setCompactionFailed405(Wgdef pb_pendingReaders;Mutexdef pb_mtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Close327(Wgdef pb_pendingReaders;Mutexdef pb_mtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	pb_mtx.Lock!false;
	pb_mtx.Unlock!false;
	pb_pendingReaders.wait?0;
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

