
// https://github.com/beego/beego/blob/master/client/cache/cache_test.go#L29
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestCacheIncr290 = [1] of {int};
	run TestCacheIncr29(child_TestCacheIncr290)
stop_process:skip
}

proctype TestCacheIncr29(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestCacheIncr38350 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
	wg.update!10;
		for(i : 0.. 10-1) {
		for10: skip;
		run AnonymousTestCacheIncr3835(wg,child_AnonymousTestCacheIncr38350);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestCacheIncr3835(Wgdef wg;chan child) {
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

