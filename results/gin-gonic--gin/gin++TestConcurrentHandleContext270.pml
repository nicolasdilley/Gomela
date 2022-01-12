// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/gin-gonic/gin/blob//gin_integration_test.go#L270
#define def_var_iterations280  ?? // mand iterations line 280
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestConcurrentHandleContext2700 = [1] of {int};
	run TestConcurrentHandleContext270(child_TestConcurrentHandleContext2700);
	run receiver(child_TestConcurrentHandleContext2700)
stop_process:skip
}

proctype TestConcurrentHandleContext270(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestConcurrentHandleContext2822780 = [1] of {int};
	Wgdef wg;
	int var_iterations = def_var_iterations280; // mand var_iterations
	run wgMonitor(wg);
	wg.update!var_iterations;
		for(i : 0.. var_iterations-1) {
		for10: skip;
		run AnonymousTestConcurrentHandleContext282278(wg,child_AnonymousTestConcurrentHandleContext2822780);
		run receiver(child_AnonymousTestConcurrentHandleContext2822780);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestConcurrentHandleContext282278(Wgdef wg;chan child) {
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

