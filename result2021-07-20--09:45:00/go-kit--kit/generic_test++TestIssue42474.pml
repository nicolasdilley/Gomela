// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/go-kit/kit/blob/60e8424101af501c525efaf67c0a2edf08667f80/metrics/generic/generic_test.go#L74
#define var_concurrency82  ?? // mand concurrency line 82
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestIssue424740 = [1] of {int};
	run TestIssue42474(child_TestIssue424740);
	run receiver(child_TestIssue424740)
stop_process:skip
}

proctype TestIssue42474(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestIssue42484790 = [1] of {int};
	Wgdef wg;
	int var_concurrency = var_concurrency82; // mand var_concurrency
	run wgMonitor(wg);
	wg.update!var_concurrency;
		for(i : 0.. var_concurrency-1) {
		for10: skip;
		run AnonymousTestIssue4248479(wg,child_AnonymousTestIssue42484790);
		run receiver(child_AnonymousTestIssue42484790);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestIssue4248479(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_operationsoperations = -2; // opt var_operationsoperations
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

