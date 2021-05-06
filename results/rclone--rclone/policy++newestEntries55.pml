#define entries55  0

// https://github.com/rclone/rclone/blob/master/backend/union/policy/newest.go#L55
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_newestEntries550 = [1] of {int};
	run newestEntries55(entries55,child_newestEntries550)
stop_process:skip
}

proctype newestEntries55(int entries;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousnewestEntries63560 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
		for(i : 0.. entries-1) {
		for10: skip;
		wg.update!1;
		run AnonymousnewestEntries6356(wg,child_AnonymousnewestEntries63560);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousnewestEntries6356(Wgdef wg;chan child) {
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

