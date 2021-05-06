
// https://github.com/kubernetes/kops/blob/master/pkg/instancegroups/rollingupdate_test.go#L1438
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRollingUpdateMaxSurgeAllNeedUpdateOneAlreadyDetached14380 = [1] of {int};
	run TestRollingUpdateMaxSurgeAllNeedUpdateOneAlreadyDetached1438(child_TestRollingUpdateMaxSurgeAllNeedUpdateOneAlreadyDetached14380)
stop_process:skip
}

proctype TestRollingUpdateMaxSurgeAllNeedUpdateOneAlreadyDetached1438(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef alreadyDetachedTest_mutex;
	Mutexdef alreadyDetachedTest_t_context_mu;
	Mutexdef alreadyDetachedTest_t_context_match_mu;
	run mutexMonitor(alreadyDetachedTest_t_context_match_mu);
	run mutexMonitor(alreadyDetachedTest_t_context_mu);
	run mutexMonitor(alreadyDetachedTest_mutex);
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

