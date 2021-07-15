#define tasks174  0

// https://github.com/kubernetes/kops/blob/master/upup/pkg/fi/executor.go#L174
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_forkJoin1740 = [1] of {int};
	run forkJoin174(tasks174,child_forkJoin1740)
stop_process:skip
}

proctype forkJoin174(int tasks;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousforkJoin1831830 = [1] of {int};
	Wgdef wg;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
		for(i : 0.. tasks-1) {
		for10: skip;
		wg.update!1;
		run AnonymousforkJoin183183(wg,child_AnonymousforkJoin1831830);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousforkJoin183183(Wgdef wg;chan child) {
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

