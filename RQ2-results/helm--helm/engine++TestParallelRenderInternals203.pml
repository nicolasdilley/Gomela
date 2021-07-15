
// https://github.com/helm/helm/blob/master/pkg/engine/engine_test.go#L203
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestParallelRenderInternals2030 = [1] of {int};
	run TestParallelRenderInternals203(child_TestParallelRenderInternals2030)
stop_process:skip
}

proctype TestParallelRenderInternals203(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestParallelRenderInternals2092090 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
		for(i : 0.. 20-1) {
		for10: skip;
		wg.update!1;
		run AnonymousTestParallelRenderInternals209209(wg,child_AnonymousTestParallelRenderInternals2092090);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestParallelRenderInternals209209(Wgdef wg;chan child) {
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

