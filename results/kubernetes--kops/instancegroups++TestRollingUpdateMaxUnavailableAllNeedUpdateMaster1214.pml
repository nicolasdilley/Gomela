
// https://github.com/kubernetes/kops/blob/master/pkg/instancegroups/rollingupdate_test.go#L1214
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRollingUpdateMaxUnavailableAllNeedUpdateMaster12140 = [1] of {int};
	run TestRollingUpdateMaxUnavailableAllNeedUpdateMaster1214(child_TestRollingUpdateMaxUnavailableAllNeedUpdateMaster12140)
stop_process:skip
}

proctype TestRollingUpdateMaxUnavailableAllNeedUpdateMaster1214(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AssertComplete11380 = [1] of {int};
	Mutexdef concurrentTest_mutex;
	Mutexdef concurrentTest_t_context_mu;
	Mutexdef concurrentTest_t_context_match_mu;
	run mutexMonitor(concurrentTest_t_context_match_mu);
	run mutexMonitor(concurrentTest_t_context_mu);
	run mutexMonitor(concurrentTest_mutex);
	run AssertComplete1138(concurrentTest_t_context_match_mu,concurrentTest_t_context_mu,concurrentTest_mutex,child_AssertComplete11380);
	child_AssertComplete11380?0;
	stop_process: skip;
	child!0
}
proctype AssertComplete1138(Mutexdef c_t_context_match_mu;Mutexdef c_t_context_mu;Mutexdef c_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_mutex.Lock!false;
	stop_process: skip;
		c_mutex.Unlock!false;
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

