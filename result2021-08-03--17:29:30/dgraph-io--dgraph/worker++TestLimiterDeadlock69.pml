// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/dgraph-io/dgraph/blob/6b188f254202f9c38b16c4769b672dd0e9d596ac/worker/proposal_test.go#L69
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestLimiterDeadlock690 = [1] of {int};
	run TestLimiterDeadlock69(child_TestLimiterDeadlock690);
	run receiver(child_TestLimiterDeadlock690)
stop_process:skip
}

proctype TestLimiterDeadlock69(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestLimiterDeadlock96960 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
		for(i : 0.. 500-1) {
		for10: skip;
		wg.update!1;
		run AnonymousTestLimiterDeadlock9696(wg,child_AnonymousTestLimiterDeadlock96960);
		run receiver(child_AnonymousTestLimiterDeadlock96960);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestLimiterDeadlock9696(Wgdef wg;chan child) {
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

