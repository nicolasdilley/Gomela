// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/containers/podman/blob//libpod/container_graph_test.go#L41
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBuildContainerGraphTwoCtrNoEdge410 = [1] of {int};
	run TestBuildContainerGraphTwoCtrNoEdge41(child_TestBuildContainerGraphTwoCtrNoEdge410);
	run receiver(child_TestBuildContainerGraphTwoCtrNoEdge410)
stop_process:skip
}

proctype TestBuildContainerGraphTwoCtrNoEdge41(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ID3271 = [1] of {int};
	Mutexdef node2_container_runtime_lock;
	chan child_ID3270 = [1] of {int};
	Mutexdef node1_container_runtime_lock;
	Mutexdef ctr2_runtime_lock;
	Mutexdef ctr1_runtime_lock;
	run mutexMonitor(ctr1_runtime_lock);
	run mutexMonitor(ctr2_runtime_lock);
	run mutexMonitor(node1_container_runtime_lock);
	run ID327(ctr1_runtime_lock,child_ID3270);
	child_ID3270?0;
	run mutexMonitor(node2_container_runtime_lock);
	run ID327(ctr2_runtime_lock,child_ID3271);
	child_ID3271?0;
	stop_process: skip;
	child!0
}
proctype ID327(Mutexdef c_runtime_lock;chan child) {
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

proctype receiver(chan c) {
c?0
}

