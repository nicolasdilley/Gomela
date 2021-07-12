// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/time/time_test.go#L1486
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestConcurrentTimerResetStop14860 = [1] of {int};
	run TestConcurrentTimerResetStop1486(child_TestConcurrentTimerResetStop14860);
	run receiver(child_TestConcurrentTimerResetStop14860)
stop_process:skip
}

proctype TestConcurrentTimerResetStop1486(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestConcurrentTimerResetStop149914991 = [1] of {int};
	chan child_AnonymousTestConcurrentTimerResetStop149314930 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
	wg.update!var_8 * 2;
		for(i : 0.. 8-1) {
		for10: skip;
		run AnonymousTestConcurrentTimerResetStop14931493(wg,child_AnonymousTestConcurrentTimerResetStop149314930);
		run receiver(child_AnonymousTestConcurrentTimerResetStop149314930);
		run AnonymousTestConcurrentTimerResetStop14991499(wg,child_AnonymousTestConcurrentTimerResetStop149914991);
		run receiver(child_AnonymousTestConcurrentTimerResetStop149914991);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestConcurrentTimerResetStop14931493(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousTestConcurrentTimerResetStop14991499(Wgdef wg;chan child) {
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

