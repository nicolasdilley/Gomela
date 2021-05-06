#define TestUpdateNodeObjects_nodes  3
#define TestUpdateNodeObjects_listers  0
#define TestUpdateNodeObjects_watchers  1

// https://github.com/kubernetes/kubernetes/blob/master/test/integration/master/synthetic_master_test.go#L715
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestUpdateNodeObjects7150 = [1] of {int};
	run TestUpdateNodeObjects715(child_TestUpdateNodeObjects7150)
stop_process:skip
}

proctype TestUpdateNodeObjects715(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestUpdateNodeObjects7847840 = [1] of {int};
	Wgdef wg;
	int nodes = TestUpdateNodeObjects_nodes;
	int listers = TestUpdateNodeObjects_listers;
	int watchers = TestUpdateNodeObjects_watchers;
	for20_exit: skip;
	for30_exit: skip;
	run wgMonitor(wg);
	wg.update!nodes - listers;
		for(i : 0.. nodes-1) {
		for40: skip;
		run AnonymousTestUpdateNodeObjects784784(wg,child_AnonymousTestUpdateNodeObjects7847840);
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

