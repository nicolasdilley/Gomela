// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/dgraph-io/dgraph/blob/6b188f254202f9c38b16c4769b672dd0e9d596ac/query/outputnode_test.go#L35
#define TestEncodeMemory_runtime_NumCPU__  ??
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestEncodeMemory350 = [1] of {int};
	run TestEncodeMemory35(child_TestEncodeMemory350);
	run receiver(child_TestEncodeMemory350)
stop_process:skip
}

proctype TestEncodeMemory35(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestEncodeMemory52390 = [1] of {int};
	Wgdef wg;
	int var_runtime_NumCPU__ = TestEncodeMemory_runtime_NumCPU__; // mand var_runtime_NumCPU__
	run wgMonitor(wg);
		for(i : 0.. var_runtime_NumCPU__-1) {
		for10: skip;
		wg.update!1;
		run AnonymousTestEncodeMemory5239(wg,child_AnonymousTestEncodeMemory52390);
		run receiver(child_AnonymousTestEncodeMemory52390);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestEncodeMemory5239(Wgdef wg;chan child) {
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

