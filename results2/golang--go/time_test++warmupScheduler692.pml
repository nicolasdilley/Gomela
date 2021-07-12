// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/time/sleep_test.go#L692
#define var_targetThreadCount692  ?? // mand var_targetThreadCount692
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_warmupScheduler6920 = [1] of {int};
	run warmupScheduler692(var_targetThreadCount692,child_warmupScheduler6920);
	run receiver(child_warmupScheduler6920)
stop_process:skip
}

proctype warmupScheduler692(int targetThreadCount;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymouswarmupScheduler6976930 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
		for(i : 0.. var_targetThreadCount-1) {
		for10: skip;
		wg.update!1;
		run AnonymouswarmupScheduler697693(wg,child_AnonymouswarmupScheduler6976930);
		run receiver(child_AnonymouswarmupScheduler6976930);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymouswarmupScheduler697693(Wgdef wg;chan child) {
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

