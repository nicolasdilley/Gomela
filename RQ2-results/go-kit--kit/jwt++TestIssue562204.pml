
// https://github.com/go-kit/kit/blob/master/auth/jwt/middleware_test.go#L204
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestIssue5622040 = [1] of {int};
	run TestIssue562204(child_TestIssue5622040)
stop_process:skip
}

proctype TestIssue562204(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestIssue5622152120 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
		for(i : 0.. 100-1) {
		for10: skip;
		wg.update!1;
		run AnonymousTestIssue562215212(wg,child_AnonymousTestIssue5622152120);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestIssue562215212(Wgdef wg;chan child) {
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

