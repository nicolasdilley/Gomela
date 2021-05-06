#define Run_p  3

// https://github.com/matryer/xbar/blob/master/pkg/plugins/plugin.go#L103
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_Run1030 = [1] of {int};
	run Run103(child_Run1030)
stop_process:skip
}

proctype Run103(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousRun1071070 = [1] of {int};
	Wgdef wg;
	int p = Run_p;
	run wgMonitor(wg);
		for(i : 0.. p-1) {
		for10: skip;
		wg.update!1;
		run AnonymousRun107107(wg,child_AnonymousRun1071070);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousRun107107(Wgdef wg;chan child) {
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

