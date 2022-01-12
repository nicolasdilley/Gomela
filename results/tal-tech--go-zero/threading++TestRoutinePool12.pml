// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/tal-tech/go-zero/blob//core/threading/taskrunner_test.go#L12
#define def_var_times18  ?? // mand times line 18
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestRoutinePool120 = [1] of {int};
	run TestRoutinePool12(child_TestRoutinePool120);
	run receiver(child_TestRoutinePool120)
stop_process:skip
}

proctype TestRoutinePool12(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Wgdef waitGroup;
	int var_times = def_var_times18; // mand var_times
	run wgMonitor(waitGroup);
		for(i : 0.. var_times-1) {
		for10: skip;
		waitGroup.update!1;
		for10_end: skip
	};
	for10_exit: skip;
	waitGroup.wait?0;
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

