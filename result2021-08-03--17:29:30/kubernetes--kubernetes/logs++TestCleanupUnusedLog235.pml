// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kubernetes/blob/0277cff2682d5a0d3c6fa2109f7f82e8db3f2ed8/pkg/kubelet/logs/container_log_manager_test.go#L235
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCleanupUnusedLog2350 = [1] of {int};
	run TestCleanupUnusedLog235(child_TestCleanupUnusedLog2350);
	run receiver(child_TestCleanupUnusedLog2350)
stop_process:skip
}

proctype TestCleanupUnusedLog235(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_cleanupUnusedLogs3020 = [1] of {int};
	Mutexdef c_mutex;
	int var_testLogs = -2; // opt var_testLogs
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
	int var_unused = -2; // opt var_unused
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

proctype receiver(chan c) {
c?0
}

