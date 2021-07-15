
// https://github.com/kubernetes/kubernetes/blob/master/pkg/registry/core/service/allocator/bitmap_test.go#L57
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAllocateError570 = [1] of {int};
	run TestAllocateError57(child_TestAllocateError570)
stop_process:skip
}

proctype TestAllocateError57(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Allocate891 = [1] of {int};
	chan child_Allocate890 = [1] of {int};
	Mutexdef m_lock;
	run mutexMonitor(m_lock);
	run Allocate89(m_lock,child_Allocate890);
	child_Allocate890?0;
	run Allocate89(m_lock,child_Allocate891);
	child_Allocate891?0;
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

