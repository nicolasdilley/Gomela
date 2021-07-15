
// https://github.com/jaegertracing/jaeger/blob/master/cmd/ingester/app/consumer/deadlock_detector_test.go#L81
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestPanicForPartition810 = [1] of {int};
	run TestPanicForPartition81(child_TestPanicForPartition810)
stop_process:skip
}

proctype TestPanicForPartition81(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Wgdef wg;
	run wgMonitor(wg);
	wg.update!1;
	wg.wait?0;
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

