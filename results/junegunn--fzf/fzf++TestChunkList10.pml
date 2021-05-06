
// https://github.com/junegunn/fzf/blob/master/src/chunklist_test.go#L10
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestChunkList100 = [1] of {int};
	run TestChunkList10(child_TestChunkList100)
stop_process:skip
}

proctype TestChunkList10(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Push558 = [1] of {int};
	chan child_Push557 = [1] of {int};
	chan child_Snapshot756 = [1] of {int};
	chan child_Push555 = [1] of {int};
	chan child_Push554 = [1] of {int};
	chan child_Snapshot753 = [1] of {int};
	chan child_Push552 = [1] of {int};
	chan child_Push551 = [1] of {int};
	chan child_Snapshot750 = [1] of {int};
	Mutexdef cl_mutex;
	run mutexMonitor(cl_mutex);
	run Snapshot75(cl_mutex,child_Snapshot750);
	child_Snapshot750?0;
	run Push55(cl_mutex,child_Push551);
	child_Push551?0;
	run Push55(cl_mutex,child_Push552);
	child_Push552?0;
	run Snapshot75(cl_mutex,child_Snapshot753);
	child_Snapshot753?0;
	

	if
	:: 0 != -2 && chunkSize * 2-1 != -3 -> 
				for(i : 0.. chunkSize * 2-1) {
			for11: skip;
			run Push55(cl_mutex,child_Push555);
			child_Push555?0;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run Push55(cl_mutex,child_Push554);
			child_Push554?0;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	run Snapshot75(cl_mutex,child_Snapshot756);
	child_Snapshot756?0;
	run Push55(cl_mutex,child_Push557);
	child_Push557?0;
	run Push55(cl_mutex,child_Push558);
	child_Push558?0;
	stop_process: skip;
	child!0
}
proctype Snapshot75(Mutexdef cl_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	cl_mutex.Lock!false;
	cl_mutex.Unlock!false;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Push55(Mutexdef cl_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	cl_mutex.Lock!false;
	cl_mutex.Unlock!false;
	goto stop_process;
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

