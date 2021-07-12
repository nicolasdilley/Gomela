// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/time/time_test.go#L1468
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestConcurrentTimerReset14680 = [1] of {int};
	run TestConcurrentTimerReset1468(child_TestConcurrentTimerReset14680);
	run receiver(child_TestConcurrentTimerReset14680)
stop_process:skip
}

proctype TestConcurrentTimerReset1468(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestConcurrentTimerReset147514750 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
	wg.update!8;
		for(i : 0.. 8-1) {
		for10: skip;
		run AnonymousTestConcurrentTimerReset14751475(wg,child_AnonymousTestConcurrentTimerReset147514750);
		run receiver(child_AnonymousTestConcurrentTimerReset147514750);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestConcurrentTimerReset14751475(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
		defer1: skip;
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

