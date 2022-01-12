// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/go-chi/chi/blob//mux_test.go#L1558
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestMuxContextIsThreadSafe15580 = [1] of {int};
	run TestMuxContextIsThreadSafe1558(child_TestMuxContextIsThreadSafe15580);
	run receiver(child_TestMuxContextIsThreadSafe15580)
stop_process:skip
}

proctype TestMuxContextIsThreadSafe1558(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestMuxContextIsThreadSafe157115670 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
		for(i : 0.. 100-1) {
		for10: skip;
		wg.update!1;
		run AnonymousTestMuxContextIsThreadSafe15711567(wg,child_AnonymousTestMuxContextIsThreadSafe157115670);
		run receiver(child_AnonymousTestMuxContextIsThreadSafe157115670);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestMuxContextIsThreadSafe15711567(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousAnonymousTestMuxContextIsThreadSafe1571158315670 = [1] of {int};
		for(i : 0.. 10000-1) {
		for11: skip;
		run AnonymousAnonymousTestMuxContextIsThreadSafe157115831567(wg,child_AnonymousAnonymousTestMuxContextIsThreadSafe1571158315670);
		run receiver(child_AnonymousAnonymousTestMuxContextIsThreadSafe1571158315670);
		for11_end: skip
	};
	for11_exit: skip;
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousAnonymousTestMuxContextIsThreadSafe157115831567(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

