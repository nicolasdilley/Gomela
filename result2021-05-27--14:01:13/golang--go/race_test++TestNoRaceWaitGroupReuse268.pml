// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/runtime/race/testdata/waitgroup_test.go#L268
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestNoRaceWaitGroupReuse2680 = [1] of {int};
	run TestNoRaceWaitGroupReuse268(child_TestNoRaceWaitGroupReuse2680);
	run receiver(child_TestNoRaceWaitGroupReuse2680)
stop_process:skip
}

proctype TestNoRaceWaitGroupReuse268(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestNoRaceWaitGroupReuse2752750 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
		for(i : 0.. 3-1) {
		for10: skip;
		wg.update!3;
				for(i : 0.. 3-1) {
			for11: skip;
			run AnonymousTestNoRaceWaitGroupReuse275275(wg,child_AnonymousTestNoRaceWaitGroupReuse2752750);
			run receiver(child_AnonymousTestNoRaceWaitGroupReuse2752750);
			for11_end: skip
		};
		for11_exit: skip;
		wg.wait?0;
		for10_end: skip
	};
	for10_exit: skip;
	stop_process: skip;
	child!0
}
proctype AnonymousTestNoRaceWaitGroupReuse275275(Wgdef wg;chan child) {
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

