// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/os/timeout_test.go#L514
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestRacyRead5140 = [1] of {int};
	run TestRacyRead514(child_TestRacyRead5140);
	run receiver(child_TestRacyRead5140)
stop_process:skip
}

proctype TestRacyRead514(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestRacyRead5325240 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
		for(i : 0.. 10-1) {
		for10: skip;
		wg.update!1;
		run AnonymousTestRacyRead532524(wg,child_AnonymousTestRacyRead5325240);
		run receiver(child_AnonymousTestRacyRead5325240);
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
proctype AnonymousTestRacyRead532524(Wgdef wg;chan child) {
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

