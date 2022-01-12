// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/tal-tech/go-zero/blob//core/syncx/cond_test.go#L27
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestTimeoutCondWaitTimeout270 = [1] of {int};
	run TestTimeoutCondWaitTimeout27(child_TestTimeoutCondWaitTimeout270);
	run receiver(child_TestTimeoutCondWaitTimeout270)
stop_process:skip
}

proctype TestTimeoutCondWaitTimeout27(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestTimeoutCondWaitTimeout31280 = [1] of {int};
	Wgdef wait;
	run wgMonitor(wait);
	wait.update!1;
	run AnonymousTestTimeoutCondWaitTimeout3128(wait,child_AnonymousTestTimeoutCondWaitTimeout31280);
	run receiver(child_AnonymousTestTimeoutCondWaitTimeout31280);
	wait.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestTimeoutCondWaitTimeout3128(Wgdef wait;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wait.update!-1;
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

