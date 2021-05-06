
// https://github.com/hashicorp/vault/blob/master/vault/acl_test.go#L805
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestACL_CreationRace8050 = [1] of {int};
	run TestACL_CreationRace805(child_TestACL_CreationRace8050)
stop_process:skip
}

proctype TestACL_CreationRace805(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestACL_CreationRace8168110 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
		for(i : 0.. 50-1) {
		for10: skip;
		wg.update!1;
		run AnonymousTestACL_CreationRace816811(wg,child_AnonymousTestACL_CreationRace8168110);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestACL_CreationRace816811(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
		wg.update!-1;
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

