// num_comm_params=3
// num_mand_comm_params=0
// num_opt_comm_params=3

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/os/timeout_test.go#L458
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestReadWriteDeadlineRace4580 = [1] of {int};
	run TestReadWriteDeadlineRace458(child_TestReadWriteDeadlineRace4580);
	run receiver(child_TestReadWriteDeadlineRace4580)
stop_process:skip
}

proctype TestReadWriteDeadlineRace458(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestReadWriteDeadlineRace4994732 = [1] of {int};
	chan child_AnonymousTestReadWriteDeadlineRace4894731 = [1] of {int};
	chan child_AnonymousTestReadWriteDeadlineRace4754730 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
	wg.update!3;
	run AnonymousTestReadWriteDeadlineRace475473(wg,child_AnonymousTestReadWriteDeadlineRace4754730);
	run receiver(child_AnonymousTestReadWriteDeadlineRace4754730);
	run AnonymousTestReadWriteDeadlineRace489473(wg,child_AnonymousTestReadWriteDeadlineRace4894731);
	run receiver(child_AnonymousTestReadWriteDeadlineRace4894731);
	run AnonymousTestReadWriteDeadlineRace499473(wg,child_AnonymousTestReadWriteDeadlineRace4994732);
	run receiver(child_AnonymousTestReadWriteDeadlineRace4994732);
	wg.wait?0;
		stop_process: skip;
		stop_process: skip;
	stop_process: skip;
	child!0
}
proctype AnonymousTestReadWriteDeadlineRace475473(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int N = -2; // opt N
		defer1: skip;
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousTestReadWriteDeadlineRace489473(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int N = -2; // opt N
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousTestReadWriteDeadlineRace499473(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int N = -2; // opt N
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

