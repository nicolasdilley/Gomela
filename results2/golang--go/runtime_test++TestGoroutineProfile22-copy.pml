// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/runtime/runtime_unix_test.go#L22
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestGoroutineProfile220 = [1] of {int};
	run TestGoroutineProfile22(child_TestGoroutineProfile220);
	run receiver(child_TestGoroutineProfile220)
stop_process:skip
}

proctype TestGoroutineProfile22(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestGoroutineProfile34310 = [1] of {int};
	Wgdef wg;
	int var_maxmax = -2; // opt var_maxmax
	run wgMonitor(wg);
		for(i : 0.. 4-1) {
		for10: skip;
		wg.update!1;
		run AnonymousTestGoroutineProfile3431(wg,child_AnonymousTestGoroutineProfile34310);
		run receiver(child_AnonymousTestGoroutineProfile34310);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestGoroutineProfile3431(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.update!-1;
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

