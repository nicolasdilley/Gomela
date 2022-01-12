// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/GoogleContainerTools/skaffold/blob//cmd/skaffold/app/signals_test.go#L29
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestCatchCtrlC290 = [1] of {int};
	run TestCatchCtrlC29(child_TestCatchCtrlC290);
	run receiver(child_TestCatchCtrlC290)
stop_process:skip
}

proctype TestCatchCtrlC29(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestCatchCtrlC36300 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
	wg.update!1;
	run AnonymousTestCatchCtrlC3630(wg,child_AnonymousTestCatchCtrlC36300);
	run receiver(child_AnonymousTestCatchCtrlC36300);
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestCatchCtrlC3630(Wgdef wg;chan child) {
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

