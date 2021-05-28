// num_comm_params=4
// num_mand_comm_params=3
// num_opt_comm_params=1

// git_link=https://github.com/kubernetes/kubernetes/blob/0277cff2682d5a0d3c6fa2109f7f82e8db3f2ed8/test/integration/master/synthetic_master_test.go#L715
#define TestUpdateNodeObjects_nodes  ??
#define TestUpdateNodeObjects_listers  ??
#define TestUpdateNodeObjects_watchers  ??
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestUpdateNodeObjects7150 = [1] of {int};
	run TestUpdateNodeObjects715(child_TestUpdateNodeObjects7150);
	run receiver(child_TestUpdateNodeObjects7150)
stop_process:skip
}

proctype TestUpdateNodeObjects715(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestUpdateNodeObjects7847840 = [1] of {int};
	Wgdef wg;
	int watchers = TestUpdateNodeObjects_watchers; // mand watchers
	int listers = TestUpdateNodeObjects_listers; // mand listers
	int nodes = TestUpdateNodeObjects_nodes; // mand nodes
	for20_exit: skip;
	for30_exit: skip;
	run wgMonitor(wg);
	wg.update!nodes - listers;
		for(i : 0.. nodes-1) {
		for40: skip;
		run AnonymousTestUpdateNodeObjects784784(wg,child_AnonymousTestUpdateNodeObjects7847840);
		run receiver(child_AnonymousTestUpdateNodeObjects7847840);
		for40_end: skip
	};
	for40_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestUpdateNodeObjects784784(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int iterations = -2; // opt iterations
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

