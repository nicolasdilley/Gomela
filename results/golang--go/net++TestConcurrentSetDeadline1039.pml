// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob//net/timeout_test.go#L1039
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestConcurrentSetDeadline10390 = [1] of {int};
	run TestConcurrentSetDeadline1039(child_TestConcurrentSetDeadline10390);
	run receiver(child_TestConcurrentSetDeadline10390)
stop_process:skip
}

proctype TestConcurrentSetDeadline1039(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestConcurrentSetDeadline106310630 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
	wg.update!8;
		for(i : 0.. 8-1) {
		for20: skip;
		run AnonymousTestConcurrentSetDeadline10631063(wg,child_AnonymousTestConcurrentSetDeadline106310630);
		run receiver(child_AnonymousTestConcurrentSetDeadline106310630);
		for20_end: skip
	};
	for20_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestConcurrentSetDeadline10631063(Wgdef wg;chan child) {
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

