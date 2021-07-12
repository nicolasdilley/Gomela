// num_comm_params=2
// num_mand_comm_params=0
// num_opt_comm_params=2

// git_link=https://github.com/gocolly/colly/blob/91e0074c7c0c7a09e3d57e277a9182a82b39b04c/context_test.go#L22
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestContextIteration220 = [1] of {int};
	run TestContextIteration22(child_TestContextIteration220);
	run receiver(child_TestContextIteration220)
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
	int var_valuesvalues = -2; // opt var_valuesvalues
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
	:: var_values-1 != -3 -> 
				for(i : 0.. var_values-1) {
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
	int var_c_contextMapc_contextMap = -2; // opt var_c_contextMapc_contextMap
	c_lock.RLock!false;
	goto defer1;
		defer1: skip;
	c_lock.RUnlock!false;
	stop_process: skip;
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
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	c_lock.RUnlock!false;
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

