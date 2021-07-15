#define TestIssue424_concurrency  3

// https://github.com/go-kit/kit/blob/master/metrics/generic/generic_test.go#L74
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestIssue424740 = [1] of {int};
	run TestIssue42474(child_TestIssue424740)
stop_process:skip
}

proctype TestIssue42474(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestIssue42484790 = [1] of {int};
	Wgdef wg;
	int concurrency = TestIssue424_concurrency;
	run wgMonitor(wg);
	wg.update!concurrency;
		for(i : 0.. concurrency-1) {
		for10: skip;
		run AnonymousTestIssue4248479(wg,child_AnonymousTestIssue42484790);
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
	stop_process: skip;
		wg.update!-1;
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

