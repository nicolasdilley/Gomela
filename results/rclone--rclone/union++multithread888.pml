#define num888  3

// https://github.com/rclone/rclone/blob/master/backend/union/union.go#L888
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_multithread8880 = [1] of {int};
	run multithread888(num888,child_multithread8880)
stop_process:skip
}

proctype multithread888(int num;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Anonymousmultithread8938890 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
		for(i : 0.. num-1) {
		for10: skip;
		wg.update!1;
		run Anonymousmultithread893889(wg,child_Anonymousmultithread8938890);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype Anonymousmultithread893889(Wgdef wg;chan child) {
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

