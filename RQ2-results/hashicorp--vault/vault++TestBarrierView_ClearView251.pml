
// https://github.com/hashicorp/vault/blob/master/vault/barrier_view_test.go#L251
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBarrierView_ClearView2510 = [1] of {int};
	run TestBarrierView_ClearView251(child_TestBarrierView_ClearView2510)
stop_process:skip
}

proctype TestBarrierView_ClearView251(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Put620 = [1] of {int};
	chan child_Put621 = [1] of {int};
	Mutexdef view_readOnlyErrLock;
	int ent = -2;
	run mutexMonitor(view_readOnlyErrLock);
	

	if
	:: ent-1 != -3 -> 
				for(i : 0.. ent-1) {
			for10: skip;
			run Put62(view_readOnlyErrLock,child_Put620);
			child_Put620?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run Put62(view_readOnlyErrLock,child_Put621);
			child_Put621?0;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype Put62(Mutexdef v_readOnlyErrLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_runICheck51 = [1] of {int};
	chan child_getReadOnlyErr430 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run getReadOnlyErr43(v_readOnlyErrLock,child_getReadOnlyErr430);
	child_getReadOnlyErr430?0;
	

	if
	:: true -> 
		run runICheck5(v_readOnlyErrLock,child_runICheck51);
		child_runICheck51?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getReadOnlyErr43(Mutexdef v_readOnlyErrLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	v_readOnlyErrLock.RLock!false;
	goto stop_process;
	stop_process: skip;
		v_readOnlyErrLock.RUnlock!false;
	child!0
}
proctype runICheck5(Mutexdef v_readOnlyErrLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

