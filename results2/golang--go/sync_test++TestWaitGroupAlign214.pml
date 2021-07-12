// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/sync/waitgroup_test.go#L214
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestWaitGroupAlign2140 = [1] of {int};
	run TestWaitGroupAlign214(child_TestWaitGroupAlign2140);
	run receiver(child_TestWaitGroupAlign2140)
stop_process:skip
}

proctype TestWaitGroupAlign214(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestWaitGroupAlign2212210 = [1] of {int};
	Wgdef x_wg;
	run wgMonitor(x_wg);
	x_wg.update!1;
	run AnonymousTestWaitGroupAlign221221(x_wg,child_AnonymousTestWaitGroupAlign2212210);
	run receiver(child_AnonymousTestWaitGroupAlign2212210);
	x_wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestWaitGroupAlign221221(Wgdef x_wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	x_wg.update!-1;
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

proctype receiver(chan c) {
c?0
}

