
// https://github.com/grpc/grpc-go/blob/master/encoding/proto/proto_test.go#L62
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestConcurrentUsage620 = [1] of {int};
	run TestConcurrentUsage62(child_TestConcurrentUsage620)
stop_process:skip
}

proctype TestConcurrentUsage62(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestConcurrentUsage82770 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
		for(i : 0.. 100-1) {
		for10: skip;
		wg.update!1;
		run AnonymousTestConcurrentUsage8277(wg,child_AnonymousTestConcurrentUsage82770);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestConcurrentUsage8277(Wgdef wg;chan child) {
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

