// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/runtime/race/testdata/waitgroup_test.go#L14
#define TestNoRaceWaitGroup_n  ??
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestNoRaceWaitGroup140 = [1] of {int};
	run TestNoRaceWaitGroup14(child_TestNoRaceWaitGroup140);
	run receiver(child_TestNoRaceWaitGroup140)
stop_process:skip
}

proctype TestNoRaceWaitGroup14(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestNoRaceWaitGroup22170 = [1] of {int};
	Wgdef wg;
	int var_n = TestNoRaceWaitGroup_n; // mand var_n
	run wgMonitor(wg);
		for(i : 0.. var_n-1) {
		for10: skip;
		wg.update!1;
		run AnonymousTestNoRaceWaitGroup2217(wg,child_AnonymousTestNoRaceWaitGroup22170);
		run receiver(child_AnonymousTestNoRaceWaitGroup22170);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestNoRaceWaitGroup2217(Wgdef wg;chan child) {
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

