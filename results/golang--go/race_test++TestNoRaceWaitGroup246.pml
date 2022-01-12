// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob//runtime/race/testdata/waitgroup_test.go#L46
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestNoRaceWaitGroup2460 = [1] of {int};
	run TestNoRaceWaitGroup246(child_TestNoRaceWaitGroup2460);
	run receiver(child_TestNoRaceWaitGroup2460)
stop_process:skip
}

proctype TestNoRaceWaitGroup246(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestNoRaceWaitGroup251490 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
	wg.update!1;
	run AnonymousTestNoRaceWaitGroup25149(wg,child_AnonymousTestNoRaceWaitGroup251490);
	run receiver(child_AnonymousTestNoRaceWaitGroup251490);
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestNoRaceWaitGroup25149(Wgdef wg;chan child) {
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

