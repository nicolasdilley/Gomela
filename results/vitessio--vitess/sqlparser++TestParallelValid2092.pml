// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/sqlparser/parse_test.go#L2092
#define def_var_parallelism2097  ?? // mand parallelism line 2097
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestParallelValid20920 = [1] of {int};
	run TestParallelValid2092(child_TestParallelValid20920);
	run receiver(child_TestParallelValid20920)
stop_process:skip
}

proctype TestParallelValid2092(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestParallelValid209920960 = [1] of {int};
	Wgdef wg;
	int var_parallelism = def_var_parallelism2097; // mand var_parallelism
	run wgMonitor(wg);
	wg.update!var_parallelism;
		for(i : 0.. var_parallelism-1) {
		for10: skip;
		run AnonymousTestParallelValid20992096(wg,child_AnonymousTestParallelValid209920960);
		run receiver(child_AnonymousTestParallelValid209920960);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestParallelValid20992096(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_numIters = -2; // opt var_numIters
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

