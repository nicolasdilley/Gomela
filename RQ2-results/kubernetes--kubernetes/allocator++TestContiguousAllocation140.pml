
// https://github.com/kubernetes/kubernetes/blob/master/pkg/registry/core/service/allocator/bitmap_test.go#L140
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestContiguousAllocation1400 = [1] of {int};
	run TestContiguousAllocation140(child_TestContiguousAllocation1400)
stop_process:skip
}

proctype TestContiguousAllocation140(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AllocateNext1032 = [1] of {int};
	chan child_AllocateNext1031 = [1] of {int};
	chan child_AllocateNext1030 = [1] of {int};
	Mutexdef m_lock;
	int max = -2;
	run mutexMonitor(m_lock);
	

	if
	:: 0 != -2 && max-1 != -3 -> 
				for(i : 0.. max-1) {
			for11: skip;
			run AllocateNext103(m_lock,child_AllocateNext1031);
			child_AllocateNext1031?0;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run AllocateNext103(m_lock,child_AllocateNext1030);
			child_AllocateNext1030?0;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	run AllocateNext103(m_lock,child_AllocateNext1032);
	child_AllocateNext1032?0;
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

