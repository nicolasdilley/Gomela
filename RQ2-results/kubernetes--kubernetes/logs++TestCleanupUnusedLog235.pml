
// https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/logs/container_log_manager_test.go#L235
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCleanupUnusedLog2350 = [1] of {int};
	run TestCleanupUnusedLog235(child_TestCleanupUnusedLog2350)
stop_process:skip
}

proctype TestCleanupUnusedLog235(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_cleanupUnusedLogs3020 = [1] of {int};
	Mutexdef c_mutex;
	run mutexMonitor(c_mutex);
	run cleanupUnusedLogs302(c_mutex,child_cleanupUnusedLogs3020);
	child_cleanupUnusedLogs3020?0;
	stop_process: skip;
	child!0
}
proctype cleanupUnusedLogs302(Mutexdef c_mutex;chan child) {
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

