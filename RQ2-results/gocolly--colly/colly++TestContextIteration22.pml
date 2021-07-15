
// https://github.com/gocolly/colly/blob/master/context_test.go#L22
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestContextIteration220 = [1] of {int};
	run TestContextIteration22(child_TestContextIteration220)
stop_process:skip
}

proctype TestContextIteration22(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetAny673 = [1] of {int};
	chan child_GetAny674 = [1] of {int};
	chan child_ForEach772 = [1] of {int};
	chan child_Put481 = [1] of {int};
	chan child_Put480 = [1] of {int};
	Mutexdef ctx_lock;
	int values = -2;
	run mutexMonitor(ctx_lock);
	

	if
	:: 0 != -2 && 10-1 != -3 -> 
				for(i : 0.. 10-1) {
			for11: skip;
			run Put48(ctx_lock,child_Put481);
			child_Put481?0;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run Put48(ctx_lock,child_Put480);
			child_Put480?0;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	run ForEach77(ctx_lock,child_ForEach772);
	child_ForEach772?0;
	

	if
	:: values-1 != -3 -> 
				for(i : 0.. values-1) {
			for30: skip;
			run GetAny67(ctx_lock,child_GetAny673);
			child_GetAny673?0;
			for30_end: skip
		};
		for30_exit: skip
	:: else -> 
		do
		:: true -> 
			for31: skip;
			run GetAny67(ctx_lock,child_GetAny674);
			child_GetAny674?0;
			for31_end: skip
		:: true -> 
			break
		od;
		for31_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype Put48(Mutexdef c_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_lock.Lock!false;
	c_lock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype ForEach77(Mutexdef c_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_lock.RLock!false;
	goto stop_process;
	stop_process: skip;
		c_lock.RUnlock!false;
	child!0
}
proctype GetAny67(Mutexdef c_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_lock.RLock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
		c_lock.RUnlock!false;
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

