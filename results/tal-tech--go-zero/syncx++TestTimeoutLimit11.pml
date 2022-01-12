// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/tal-tech/go-zero/blob//core/syncx/timeoutlimit_test.go#L11
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestTimeoutLimit110 = [1] of {int};
	run TestTimeoutLimit11(child_TestTimeoutLimit110);
	run receiver(child_TestTimeoutLimit110)
stop_process:skip
}

proctype TestTimeoutLimit11(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestTimeoutLimit19150 = [1] of {int};
	Wgdef wait3;
	Wgdef wait2;
	Wgdef wait1;
	run wgMonitor(wait1);
	run wgMonitor(wait2);
	run wgMonitor(wait3);
	wait1.update!1;
	wait2.update!1;
	wait3.update!1;
	run AnonymousTestTimeoutLimit1915(wait3,wait1,wait2,child_AnonymousTestTimeoutLimit19150);
	run receiver(child_AnonymousTestTimeoutLimit19150);
	wait1.update!-1;
	wait2.wait?0;
	wait3.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestTimeoutLimit1915(Wgdef wait3;Wgdef wait1;Wgdef wait2;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wait1.wait?0;
	wait2.update!-1;
	wait3.update!-1;
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

