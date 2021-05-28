// num_comm_params=2
// num_mand_comm_params=0
// num_opt_comm_params=2

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/math/rand/race_test.go#L14
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestConcurrent140 = [1] of {int};
	run TestConcurrent14(child_TestConcurrent140);
	run receiver(child_TestConcurrent140)
stop_process:skip
}

proctype TestConcurrent14(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestConcurrent23230 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
	wg.update!10;
		for(i : 0.. 10-1) {
		for10: skip;
		run AnonymousTestConcurrent2323(wg,child_AnonymousTestConcurrent23230);
		run receiver(child_AnonymousTestConcurrent23230);
		for10_end: skip
	};
	for10_exit: skip;
		defer1: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestConcurrent2323(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int buf = -2; // opt buf
	int Perm_10_ = -2; // opt Perm_10_
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

