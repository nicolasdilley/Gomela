
// https://github.com/kubernetes/kubernetes/blob/master/pkg/registry/core/service/allocator/bitmap_test.go#L118
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestSnapshotAndRestore1180 = [1] of {int};
	run TestSnapshotAndRestore118(child_TestSnapshotAndRestore1180)
stop_process:skip
}

proctype TestSnapshotAndRestore118(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Has1613 = [1] of {int};
	chan child_Restore1842 = [1] of {int};
	Mutexdef m2_lock;
	chan child_Snapshot1761 = [1] of {int};
	chan child_Allocate890 = [1] of {int};
	Mutexdef m_lock;
	run mutexMonitor(m_lock);
	run Allocate89(m_lock,child_Allocate890);
	child_Allocate890?0;
	run Snapshot176(m_lock,child_Snapshot1761);
	child_Snapshot1761?0;
	run mutexMonitor(m2_lock);
	run Restore184(m2_lock,child_Restore1842);
	child_Restore1842?0;
	run Has161(m2_lock,child_Has1613);
	child_Has1613?0;
	stop_process: skip;
	child!0
}
proctype Allocate89(Mutexdef r_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	r_lock.Lock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
		r_lock.Unlock!false;
	child!0
}
proctype Snapshot176(Mutexdef r_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	r_lock.Lock!false;
	goto stop_process;
	stop_process: skip;
		r_lock.Unlock!false;
	child!0
}
proctype Restore184(Mutexdef r_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	r_lock.Lock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
		r_lock.Unlock!false;
	child!0
}
proctype Has161(Mutexdef r_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	r_lock.Lock!false;
	goto stop_process;
	stop_process: skip;
		r_lock.Unlock!false;
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

