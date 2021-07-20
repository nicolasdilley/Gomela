// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kubernetes/blob/0277cff2682d5a0d3c6fa2109f7f82e8db3f2ed8/test/integration/scheduler/priorities_test.go#L406
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
	chan child_TestDefaultPodTopologySpreadScore4060 = [1] of {int};
	run TestDefaultPodTopologySpreadScore406(child_TestDefaultPodTopologySpreadScore4060);
	run receiver(child_TestDefaultPodTopologySpreadScore4060)
stop_process:skip
}

proctype TestDefaultPodTopologySpreadScore406(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef testCtx_HTTPServer_mu;
	Wgdef testCtx_HTTPServer_wg;
	int var_zoneCntszoneCnts = -2; // opt var_zoneCntszoneCnts
	int var_podspods = -2; // opt var_podspods
	int var_podList_ItemspodList_Items = -2; // opt var_podList_ItemspodList_Items
	int var_nPodsnPods = -2; // opt var_nPodsnPods
	run wgMonitor(testCtx_HTTPServer_wg);
	run mutexMonitor(testCtx_HTTPServer_mu);
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
