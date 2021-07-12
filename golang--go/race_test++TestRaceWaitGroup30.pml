// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/runtime/race/testdata/waitgroup_test.go#L30
#define TestRaceWaitGroup_n  ??
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestRaceWaitGroup300 = [1] of {int};
	run TestRaceWaitGroup30(child_TestRaceWaitGroup300);
	run receiver(child_TestRaceWaitGroup300)
stop_process:skip
}

proctype TestRaceWaitGroup30(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestRaceWaitGroup38330 = [1] of {int};
	Wgdef wg;
	int var_n = TestRaceWaitGroup_n; // mand var_n
	run wgMonitor(wg);
		for(i : 0.. var_n-1) {
		for10: skip;
		wg.update!1;
		run AnonymousTestRaceWaitGroup3833(wg,child_AnonymousTestRaceWaitGroup38330);
		run receiver(child_AnonymousTestRaceWaitGroup38330);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestRaceWaitGroup3833(Wgdef wg;chan child) {
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

