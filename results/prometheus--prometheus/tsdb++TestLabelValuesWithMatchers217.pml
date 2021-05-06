
// https://github.com/prometheus/prometheus/blob/master/tsdb/block_test.go#L217
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
	chan child_TestLabelValuesWithMatchers2170 = [1] of {int};
	run TestLabelValuesWithMatchers217(child_TestLabelValuesWithMatchers2170)
stop_process:skip
}

proctype TestLabelValuesWithMatchers217(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close3270 = [1] of {int};
	chan child_Index3771 = [1] of {int};
	Wgdef block_pendingReaders;
	Mutexdef block_mtx;
	run mutexMonitor(block_mtx);
	run wgMonitor(block_pendingReaders);
	run Index377(block_pendingReaders,block_mtx,child_Index3771);
	child_Index3771?0;
	stop_process: skip;
		run Close327(block_pendingReaders,block_mtx,child_Close3270);
	child_Close3270?0;
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
proctype Index377(Wgdef pb_pendingReaders;Mutexdef pb_mtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_startRead3651 = [1] of {int};
	run startRead365(pb_pendingReaders,pb_mtx,child_startRead3651);
	child_startRead3651?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype startRead365(Wgdef pb_pendingReaders;Mutexdef pb_mtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	pb_mtx.RLock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	pb_pendingReaders.update!1;
	goto stop_process;
	stop_process: skip;
		pb_mtx.RUnlock!false;
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

