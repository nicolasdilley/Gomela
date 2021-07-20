// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/matryer/xbar/blob/cf3d7b622a9128dc92ec3eca44cecb0ea51ec283/pkg/plugins/plugin.go#L103
#define var_p105  ?? // mand p line 105
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_Run1030 = [1] of {int};
	run Run103(child_Run1030);
	run receiver(child_Run1030)
stop_process:skip
}

proctype Run103(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousRun1071070 = [1] of {int};
	Wgdef wg;
	int var_p = var_p105; // mand var_p
	run wgMonitor(wg);
		for(i : 0.. var_p-1) {
		for10: skip;
		wg.update!1;
		run AnonymousRun107107(wg,child_AnonymousRun1071070);
		run receiver(child_AnonymousRun1071070);
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

proctype receiver(chan c) {
c?0
}

