// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/rclone/rclone/blob//backend/union/policy/newest.go#L55
#define def_var_entries  0 // mand entries line 55
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_newestEntries550 = [1] of {int};
	run newestEntries55(def_var_entries,child_newestEntries550);
	run receiver(child_newestEntries550)
stop_process:skip
}

proctype newestEntries55(int var_entries;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousnewestEntries63560 = [1] of {int};
	Wgdef wg;
	int var_mtimes = -2; // opt var_mtimes
	run wgMonitor(wg);
		for(i : 0.. var_entries-1) {
		for10: skip;
		wg.update!1;
		run AnonymousnewestEntries6356(wg,child_AnonymousnewestEntries63560);
		run receiver(child_AnonymousnewestEntries63560);
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
		defer1: skip;
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

proctype receiver(chan c) {
c?0
}

