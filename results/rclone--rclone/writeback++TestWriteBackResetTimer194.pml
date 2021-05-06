
// https://github.com/rclone/rclone/blob/master/vfs/vfscache/writeback/writeback_test.go#L194
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestWriteBackResetTimer1940 = [1] of {int};
	run TestWriteBackResetTimer194(child_TestWriteBackResetTimer1940)
stop_process:skip
}

proctype TestWriteBackResetTimer194(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_assertTimerRunning1824 = [1] of {int};
	chan child__resetTimer2183 = [1] of {int};
	chan child__newItem1382 = [1] of {int};
	chan child_assertTimerRunning1821 = [1] of {int};
	chan child__resetTimer2180 = [1] of {int};
	Mutexdef wb_mu;
	run mutexMonitor(wb_mu);
	run _resetTimer218(wb_mu,child__resetTimer2180);
	child__resetTimer2180?0;
	run assertTimerRunning182(wb_mu,child_assertTimerRunning1821);
	child_assertTimerRunning1821?0;
	run _newItem138(wb_mu,child__newItem1382);
	child__newItem1382?0;
	run _resetTimer218(wb_mu,child__resetTimer2183);
	child__resetTimer2183?0;
	run assertTimerRunning182(wb_mu,child_assertTimerRunning1824);
	child_assertTimerRunning1824?0;
	stop_process: skip;
	child!0
}
proctype _resetTimer218(Mutexdef wb_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child__stopTimer2051 = [1] of {int};
	chan child__peekItem1970 = [1] of {int};
	run _peekItem197(wb_mu,child__peekItem1970);
	child__peekItem1970?0;
	

	if
	:: true -> 
		run _stopTimer205(wb_mu,child__stopTimer2051);
		child__stopTimer2051?0
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	stop_process: skip;
	child!0
}
proctype _peekItem197(Mutexdef wb_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype _stopTimer205(Mutexdef wb_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype assertTimerRunning182(Mutexdef wb_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wb_mu.Lock!false;
	wb_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype _newItem138(Mutexdef wb_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child__pushItem1774 = [1] of {int};
	chan child__addItem1543 = [1] of {int};
	chan child_SetID2432 = [1] of {int};
	run SetID243(wb_mu,child_SetID2432);
	child_SetID2432?0;
	run _addItem154(wb_mu,child__addItem1543);
	child__addItem1543?0;
	run _pushItem177(wb_mu,child__pushItem1774);
	child__pushItem1774?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype SetID243(Mutexdef wb_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype _addItem154(Mutexdef wb_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype _pushItem177(Mutexdef wb_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

