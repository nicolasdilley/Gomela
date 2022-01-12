// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/containers/podman/blob//libpod/container_graph_test.go#L18
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBuildContainerGraphOneCtr180 = [1] of {int};
	run TestBuildContainerGraphOneCtr18(child_TestBuildContainerGraphOneCtr180);
	run receiver(child_TestBuildContainerGraphOneCtr180)
stop_process:skip
}

proctype TestBuildContainerGraphOneCtr18(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ID3272 = [1] of {int};
	chan child_ID3271 = [1] of {int};
	chan child_ID3270 = [1] of {int};
	Mutexdef node_container_runtime_lock;
	Mutexdef ctr1_runtime_lock;
	run mutexMonitor(ctr1_runtime_lock);
	run mutexMonitor(node_container_runtime_lock);
	run ID327(ctr1_runtime_lock,child_ID3270);
	child_ID3270?0;
	run ID327(ctr1_runtime_lock,child_ID3271);
	child_ID3271?0;
	run ID327(ctr1_runtime_lock,child_ID3272);
	child_ID3272?0;
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

