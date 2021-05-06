
// https://github.com/uber-go/zap/blob/master/field_test.go#L42
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_assertCanBeReused420 = [1] of {int};
	run assertCanBeReused42(child_assertCanBeReused420)
stop_process:skip
}

proctype assertCanBeReused42(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousassertCanBeReused51430 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
		for(i : 0.. 100-1) {
		for10: skip;
		wg.update!1;
		run AnonymousassertCanBeReused5143(wg,child_AnonymousassertCanBeReused51430);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousassertCanBeReused5143(Wgdef wg;chan child) {
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

