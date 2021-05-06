
// https://github.com/hashicorp/vault/blob/master/vault/barrier_view_test.go#L51
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBarrierView510 = [1] of {int};
	run TestBarrierView51(child_TestBarrierView510)
stop_process:skip
}

proctype TestBarrierView51(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Delete803 = [1] of {int};
	chan child_Put622 = [1] of {int};
	chan child_Get571 = [1] of {int};
	chan child_List530 = [1] of {int};
	Mutexdef view_readOnlyErrLock;
	run mutexMonitor(view_readOnlyErrLock);
	run List53(view_readOnlyErrLock,child_List530);
	child_List530?0;
	run Get57(view_readOnlyErrLock,child_Get571);
	child_Get571?0;
	run Put62(view_readOnlyErrLock,child_Put622);
	child_Put622?0;
	run Delete80(view_readOnlyErrLock,child_Delete803);
	child_Delete803?0;
	stop_process: skip;
	child!0
}
proctype List53(Mutexdef v_readOnlyErrLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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
proctype Put62(Mutexdef v_readOnlyErrLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_runICheck53 = [1] of {int};
	chan child_getReadOnlyErr432 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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
	chan child_runICheck54 = [1] of {int};
	chan child_getReadOnlyErr433 = [1] of {int};
	run getReadOnlyErr43(v_readOnlyErrLock,child_getReadOnlyErr433);
	child_getReadOnlyErr433?0;
	

	if
	:: true -> 
		run runICheck5(v_readOnlyErrLock,child_runICheck54);
		child_runICheck54?0;
		

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

