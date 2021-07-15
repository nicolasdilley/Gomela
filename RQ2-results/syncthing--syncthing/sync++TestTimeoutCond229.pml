
// https://github.com/syncthing/syncthing/blob/master/lib/sync/sync_test.go#L229
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestTimeoutCond2290 = [1] of {int};
	run TestTimeoutCond229(child_TestTimeoutCond2290)
stop_process:skip
}

proctype TestTimeoutCond229(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestTimeoutCond2672630 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
		for(i : 0.. 10-1) {
		for10: skip;
		wg.update!1;
		run AnonymousTestTimeoutCond267263(wg,child_AnonymousTestTimeoutCond2672630);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestTimeoutCond267263(Wgdef wg;chan child) {
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

