// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob//runtime/race/testdata/waitgroup_test.go#L193
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestRaceWaitGroup21930 = [1] of {int};
	run TestRaceWaitGroup2193(child_TestRaceWaitGroup21930);
	run receiver(child_TestRaceWaitGroup21930)
stop_process:skip
}

proctype TestRaceWaitGroup2193(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestRaceWaitGroup22021961 = [1] of {int};
	chan child_AnonymousTestRaceWaitGroup21981960 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
	wg.update!2;
	run AnonymousTestRaceWaitGroup2198196(wg,child_AnonymousTestRaceWaitGroup21981960);
	run receiver(child_AnonymousTestRaceWaitGroup21981960);
	run AnonymousTestRaceWaitGroup2202196(wg,child_AnonymousTestRaceWaitGroup22021961);
	run receiver(child_AnonymousTestRaceWaitGroup22021961);
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestRaceWaitGroup2198196(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousTestRaceWaitGroup2202196(Wgdef wg;chan child) {
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

