
// https://github.com/pingcap/tidb/blob/master/util/execdetails/execdetails_test.go#L33
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestString330 = [1] of {int};
	run TestString33(child_TestString330)
stop_process:skip
}

proctype TestString33(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_String1111 = [1] of {int};
	chan child_String1110 = [1] of {int};
	Mutexdef detail_LockKeysDetail_Mu;
	Mutexdef detail_CommitDetail_Mu;
	run mutexMonitor(detail_CommitDetail_Mu);
	run mutexMonitor(detail_LockKeysDetail_Mu);
	run String111(detail_CommitDetail_Mu,detail_LockKeysDetail_Mu,child_String1110);
	child_String1110?0;
	run String111(detail_CommitDetail_Mu,detail_LockKeysDetail_Mu,child_String1111);
	child_String1111?0;
	stop_process: skip;
	child!0
}
proctype String111(Mutexdef d_CommitDetail_Mu;Mutexdef d_LockKeysDetail_Mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef commitDetails_Mu;
	run mutexMonitor(commitDetails_Mu);
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

