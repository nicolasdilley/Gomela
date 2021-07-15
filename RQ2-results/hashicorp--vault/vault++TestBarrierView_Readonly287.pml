
// https://github.com/hashicorp/vault/blob/master/vault/barrier_view_test.go#L287
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBarrierView_Readonly2870 = [1] of {int};
	run TestBarrierView_Readonly287(child_TestBarrierView_Readonly2870)
stop_process:skip
}

proctype TestBarrierView_Readonly287(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Get573 = [1] of {int};
	chan child_Delete802 = [1] of {int};
	chan child_Put621 = [1] of {int};
	chan child_Put620 = [1] of {int};
	Mutexdef view_readOnlyErrLock;
	run mutexMonitor(view_readOnlyErrLock);
	run Put62(view_readOnlyErrLock,child_Put620);
	child_Put620?0;
	run Put62(view_readOnlyErrLock,child_Put621);
	child_Put621?0;
	run Delete80(view_readOnlyErrLock,child_Delete802);
	child_Delete802?0;
	run Get57(view_readOnlyErrLock,child_Get573);
	child_Get573?0;
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
proctype Delete80(Mutexdef v_readOnlyErrLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_runICheck53 = [1] of {int};
	chan child_getReadOnlyErr432 = [1] of {int};
	run getReadOnlyErr43(v_readOnlyErrLock,child_getReadOnlyErr432);
	child_getReadOnlyErr432?0;
	

	if
	:: true -> 
		run runICheck5(v_readOnlyErrLock,child_runICheck53);
		child_runICheck53?0;
		

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
proctype Get57(Mutexdef v_readOnlyErrLock;chan child) {
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

