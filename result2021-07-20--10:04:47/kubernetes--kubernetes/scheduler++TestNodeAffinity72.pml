// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kubernetes/blob/0277cff2682d5a0d3c6fa2109f7f82e8db3f2ed8/test/integration/scheduler/priorities_test.go#L72
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
	chan child_TestNodeAffinity720 = [1] of {int};
	run TestNodeAffinity72(child_TestNodeAffinity720);
	run receiver(child_TestNodeAffinity720)
stop_process:skip
}

proctype TestNodeAffinity72(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_createAndWaitForNodesInCache1650 = [1] of {int};
	Mutexdef testCtx_HTTPServer_mu;
	Wgdef testCtx_HTTPServer_wg;
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
