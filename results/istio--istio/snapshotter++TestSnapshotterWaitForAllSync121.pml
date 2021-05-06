
// https://github.com/istio/istio/blob/master/galley/pkg/config/processing/snapshotter/snapshotter_test.go#L121
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestSnapshotterWaitForAllSync1210 = [1] of {int};
	run TestSnapshotterWaitForAllSync121(child_TestSnapshotterWaitForAllSync1210)
stop_process:skip
}

proctype TestSnapshotterWaitForAllSync121(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetSnapshot701 = [1] of {int};
	chan child_GetSnapshot700 = [1] of {int};
	Mutexdef d_snapshotsLock;
	run mutexMonitor(d_snapshotsLock);
	run GetSnapshot70(d_snapshotsLock,child_GetSnapshot700);
	child_GetSnapshot700?0;
	run GetSnapshot70(d_snapshotsLock,child_GetSnapshot701);
	child_GetSnapshot701?0;
	stop_process: skip;
	child!0
}
proctype GetSnapshot70(Mutexdef d_snapshotsLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	d_snapshotsLock.Lock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
		d_snapshotsLock.Unlock!false;
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

