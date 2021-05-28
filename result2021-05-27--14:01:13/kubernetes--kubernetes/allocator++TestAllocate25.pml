// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kubernetes/blob/0277cff2682d5a0d3c6fa2109f7f82e8db3f2ed8/pkg/registry/core/service/allocator/bitmap_test.go#L25
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAllocate250 = [1] of {int};
	run TestAllocate25(child_TestAllocate250);
	run receiver(child_TestAllocate250)
stop_process:skip
}

proctype TestAllocate25(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Free1691 = [1] of {int};
	chan child_AllocateNext1030 = [1] of {int};
	Mutexdef m_lock;
	run mutexMonitor(m_lock);
	run AllocateNext103(m_lock,child_AllocateNext1030);
	child_AllocateNext1030?0;
	run Free169(m_lock,child_Free1691);
	child_Free1691?0;
	stop_process: skip;
	child!0
}
proctype AllocateNext103(Mutexdef r_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	r_lock.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	r_lock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Free169(Mutexdef r_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	r_lock.Lock!false;
	goto defer1;
		defer1: skip;
	r_lock.Unlock!false;
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

proctype receiver(chan c) {
c?0
}

