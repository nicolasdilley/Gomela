
// https://github.com/dgraph-io/dgraph/blob/master/worker/proposal_test.go#L69
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestLimiterDeadlock690 = [1] of {int};
	run TestLimiterDeadlock69(child_TestLimiterDeadlock690)
stop_process:skip
}

proctype TestLimiterDeadlock69(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestLimiterDeadlock96960 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
		for(i : 0.. 500-1) {
		for10: skip;
		wg.update!1;
		run AnonymousTestLimiterDeadlock9696(wg,child_AnonymousTestLimiterDeadlock96960);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestLimiterDeadlock9696(Wgdef wg;chan child) {
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

