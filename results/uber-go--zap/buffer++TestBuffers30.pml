
// https://github.com/uber-go/zap/blob/master/buffer/pool_test.go#L30
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestBuffers300 = [1] of {int};
	run TestBuffers30(child_TestBuffers300)
stop_process:skip
}

proctype TestBuffers30(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestBuffers37340 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
		for(i : 0.. 10-1) {
		for10: skip;
		wg.update!1;
		run AnonymousTestBuffers3734(wg,child_AnonymousTestBuffers37340);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestBuffers3734(Wgdef wg;chan child) {
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

