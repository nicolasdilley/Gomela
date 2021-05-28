// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/os/timeout_test.go#L553
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestRacyWrite5530 = [1] of {int};
	run TestRacyWrite553(child_TestRacyWrite5530);
	run receiver(child_TestRacyWrite5530)
stop_process:skip
}

proctype TestRacyWrite553(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestRacyWrite5715630 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
		for(i : 0.. 10-1) {
		for10: skip;
		wg.update!1;
		run AnonymousTestRacyWrite571563(wg,child_AnonymousTestRacyWrite5715630);
		run receiver(child_AnonymousTestRacyWrite5715630);
		for10_end: skip
	};
	for10_exit: skip;
		defer1: skip;
	wg.wait?0;
		stop_process: skip;
		stop_process: skip;
	stop_process: skip;
	child!0
}
proctype AnonymousTestRacyWrite571563(Wgdef wg;chan child) {
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

