#define TestEncodeMemory_runtime_NumCPU__  3

// https://github.com/dgraph-io/dgraph/blob/master/query/outputnode_test.go#L35
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestEncodeMemory350 = [1] of {int};
	run TestEncodeMemory35(child_TestEncodeMemory350)
stop_process:skip
}

proctype TestEncodeMemory35(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestEncodeMemory52390 = [1] of {int};
	Wgdef wg;
	int runtime_NumCPU__ = TestEncodeMemory_runtime_NumCPU__;
	run wgMonitor(wg);
		for(i : 0.. runtime_NumCPU__-1) {
		for10: skip;
		wg.update!1;
		run AnonymousTestEncodeMemory5239(wg,child_AnonymousTestEncodeMemory52390);
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

