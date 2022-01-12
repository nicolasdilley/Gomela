// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob//encoding/xml/marshal_test.go#L2385
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestRace979623850 = [1] of {int};
	run TestRace97962385(child_TestRace979623850);
	run receiver(child_TestRace979623850)
stop_process:skip
}

proctype TestRace97962385(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestRace9796239323900 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
		for(i : 0.. 2-1) {
		for10: skip;
		wg.update!1;
		run AnonymousTestRace979623932390(wg,child_AnonymousTestRace9796239323900);
		run receiver(child_AnonymousTestRace9796239323900);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestRace979623932390(Wgdef wg;chan child) {
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

