// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kubernetes/blob/0277cff2682d5a0d3c6fa2109f7f82e8db3f2ed8/test/integration/scheduler/framework_test.go#L1134
#define def_var_tests1225  ?? // mand tests line 1225
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBindPlugin11340 = [1] of {int};
	run TestBindPlugin1134(child_TestBindPlugin11340);
	run receiver(child_TestBindPlugin11340)
stop_process:skip
}

proctype TestBindPlugin1134(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_createAndWaitForNodesInCache1650 = [1] of {int};
	Mutexdef testCtx_HTTPServer_mu;
	Wgdef testCtx_HTTPServer_wg;
	Mutexdef testContext_HTTPServer_mu;
	Wgdef testContext_HTTPServer_wg;
	int var_test_expectInvokeEvents = -2; // opt var_test_expectInvokeEvents
	int var_tests = def_var_tests1225; // mand var_tests
	run wgMonitor(testContext_HTTPServer_wg);
	run mutexMonitor(testContext_HTTPServer_mu);
	run wgMonitor(testCtx_HTTPServer_wg);
	run mutexMonitor(testCtx_HTTPServer_mu);
	run createAndWaitForNodesInCache165(testCtx_HTTPServer_wg,testCtx_HTTPServer_mu,child_createAndWaitForNodesInCache1650);
	child_createAndWaitForNodesInCache1650?0;
	stop_process: skip;
	child!0
}
proctype createAndWaitForNodesInCache165(Wgdef testCtx_HTTPServer_wg;Mutexdef testCtx_HTTPServer_mu;chan child) {
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

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

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

