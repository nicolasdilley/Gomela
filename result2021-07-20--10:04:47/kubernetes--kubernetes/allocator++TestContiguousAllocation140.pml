// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kubernetes/blob/0277cff2682d5a0d3c6fa2109f7f82e8db3f2ed8/pkg/registry/core/service/allocator/bitmap_test.go#L140
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestContiguousAllocation1400 = [1] of {int};
	run TestContiguousAllocation140(child_TestContiguousAllocation1400);
	run receiver(child_TestContiguousAllocation1400)
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
	int var_maxmax = -2; // opt var_maxmax
	run mutexMonitor(m_lock);
	

	if
	:: 0 != -2 && var_max-1 != -3 -> 
				for(i : 0.. var_max-1) {
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
		goto defer1
	:: true;
	fi;
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

