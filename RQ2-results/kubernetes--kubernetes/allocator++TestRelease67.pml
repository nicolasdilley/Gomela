
// https://github.com/kubernetes/kubernetes/blob/master/pkg/registry/core/service/allocator/bitmap_test.go#L67
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRelease670 = [1] of {int};
	run TestRelease67(child_TestRelease670)
stop_process:skip
}

proctype TestRelease67(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Has1613 = [1] of {int};
	chan child_Release1192 = [1] of {int};
	chan child_Has1611 = [1] of {int};
	chan child_Allocate890 = [1] of {int};
	Mutexdef m_lock;
	run mutexMonitor(m_lock);
	run Allocate89(m_lock,child_Allocate890);
	child_Allocate890?0;
	run Has161(m_lock,child_Has1611);
	child_Has1611?0;
	run Release119(m_lock,child_Release1192);
	child_Release1192?0;
	run Has161(m_lock,child_Has1613);
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
proctype Release119(Mutexdef r_lock;chan child) {
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

