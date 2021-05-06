
// https://github.com/asim/go-micro/blob/master/server/rpc_stream_test.go#L96
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestRPCStream_Concurrency960 = [1] of {int};
	run TestRPCStream_Concurrency96(child_TestRPCStream_Concurrency960)
stop_process:skip
}

proctype TestRPCStream_Concurrency96(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestRPCStream_Concurrency1221061 = [1] of {int};
	chan child_AnonymousTestRPCStream_Concurrency1111060 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
		for(i : 0.. 10-1) {
		for10: skip;
		wg.update!2;
		run AnonymousTestRPCStream_Concurrency111106(wg,child_AnonymousTestRPCStream_Concurrency1111060);
		run AnonymousTestRPCStream_Concurrency122106(wg,child_AnonymousTestRPCStream_Concurrency1221061);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestRPCStream_Concurrency111106(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousTestRPCStream_Concurrency122106(Wgdef wg;chan child) {
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

