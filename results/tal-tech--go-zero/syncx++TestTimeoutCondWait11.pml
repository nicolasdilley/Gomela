// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/tal-tech/go-zero/blob//core/syncx/cond_test.go#L11
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestTimeoutCondWait110 = [1] of {int};
	run TestTimeoutCondWait11(child_TestTimeoutCondWait110);
	run receiver(child_TestTimeoutCondWait110)
stop_process:skip
}

proctype TestTimeoutCondWait11(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestTimeoutCondWait20121 = [1] of {int};
	chan child_AnonymousTestTimeoutCondWait15120 = [1] of {int};
	Wgdef wait;
	run wgMonitor(wait);
	wait.update!2;
	run AnonymousTestTimeoutCondWait1512(wait,child_AnonymousTestTimeoutCondWait15120);
	run receiver(child_AnonymousTestTimeoutCondWait15120);
	run AnonymousTestTimeoutCondWait2012(wait,child_AnonymousTestTimeoutCondWait20121);
	run receiver(child_AnonymousTestTimeoutCondWait20121);
	wait.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestTimeoutCondWait1512(Wgdef wait;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wait.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousTestTimeoutCondWait2012(Wgdef wait;chan child) {
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

