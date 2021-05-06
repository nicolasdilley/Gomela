#define TestClearStatus_test_SupportedCollections  3

// https://github.com/istio/istio/blob/master/pkg/mcp/snapshot/snapshot_test.go#L292
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestClearStatus2920 = [1] of {int};
	run TestClearStatus292(child_TestClearStatus2920)
stop_process:skip
}

proctype TestClearStatus292(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef c_mu;
	int test_SupportedCollections = TestClearStatus_test_SupportedCollections;
	run mutexMonitor(c_mu);
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

