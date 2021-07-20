// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/dapr/dapr/blob/ab83d3535478699a2f2707d9ed9008f78c155d6d/pkg/runtime/runtime_test.go#L1276
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestExtractComponentCategory12760 = [1] of {int};
	run TestExtractComponentCategory1276(child_TestExtractComponentCategory12760);
	run receiver(child_TestExtractComponentCategory12760)
stop_process:skip
}

proctype TestExtractComponentCategory1276(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef rt_grpc_lock;
	Mutexdef rt_componentsLock;
	int var_compCategoryTestscompCategoryTests = -2; // opt var_compCategoryTestscompCategoryTests
	run mutexMonitor(rt_componentsLock);
	run mutexMonitor(rt_grpc_lock);
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
