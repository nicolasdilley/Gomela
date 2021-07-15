
// https://github.com/uber-go/zap/blob/master/zapcore/sampler_test.go#L155
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestSamplerConcurrent1550 = [1] of {int};
	run TestSamplerConcurrent155(child_TestSamplerConcurrent1550)
stop_process:skip
}

proctype TestSamplerConcurrent155(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestSamplerConcurrent1741740 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
		for(i : 0.. 10-1) {
		for10: skip;
		wg.update!1;
		run AnonymousTestSamplerConcurrent174174(wg,child_AnonymousTestSamplerConcurrent1741740);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestSamplerConcurrent174174(Wgdef wg;chan child) {
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

