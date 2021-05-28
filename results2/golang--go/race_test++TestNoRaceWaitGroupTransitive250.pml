// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/runtime/race/testdata/waitgroup_test.go#L250
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestNoRaceWaitGroupTransitive2500 = [1] of {int};
	run TestNoRaceWaitGroupTransitive250(child_TestNoRaceWaitGroupTransitive2500);
	run receiver(child_TestNoRaceWaitGroupTransitive2500)
stop_process:skip
}

proctype TestNoRaceWaitGroupTransitive250(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestNoRaceWaitGroupTransitive2582521 = [1] of {int};
	chan child_AnonymousTestNoRaceWaitGroupTransitive2542520 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
	wg.update!2;
	run AnonymousTestNoRaceWaitGroupTransitive254252(wg,child_AnonymousTestNoRaceWaitGroupTransitive2542520);
	run receiver(child_AnonymousTestNoRaceWaitGroupTransitive2542520);
	run AnonymousTestNoRaceWaitGroupTransitive258252(wg,child_AnonymousTestNoRaceWaitGroupTransitive2582521);
	run receiver(child_AnonymousTestNoRaceWaitGroupTransitive2582521);
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestNoRaceWaitGroupTransitive254252(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousTestNoRaceWaitGroupTransitive258252(Wgdef wg;chan child) {
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

