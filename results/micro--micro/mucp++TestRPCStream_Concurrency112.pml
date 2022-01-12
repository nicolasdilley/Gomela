// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/micro/micro/blob//service/server/mucp/rpc_stream_test.go#L112
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestRPCStream_Concurrency1120 = [1] of {int};
	run TestRPCStream_Concurrency112(child_TestRPCStream_Concurrency1120);
	run receiver(child_TestRPCStream_Concurrency1120)
stop_process:skip
}

proctype TestRPCStream_Concurrency112(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestRPCStream_Concurrency1381221 = [1] of {int};
	chan child_AnonymousTestRPCStream_Concurrency1271220 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
		for(i : 0.. 10-1) {
		for10: skip;
		wg.update!2;
		run AnonymousTestRPCStream_Concurrency127122(wg,child_AnonymousTestRPCStream_Concurrency1271220);
		run receiver(child_AnonymousTestRPCStream_Concurrency1271220);
		run AnonymousTestRPCStream_Concurrency138122(wg,child_AnonymousTestRPCStream_Concurrency1381221);
		run receiver(child_AnonymousTestRPCStream_Concurrency1381221);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestRPCStream_Concurrency127122(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousTestRPCStream_Concurrency138122(Wgdef wg;chan child) {
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

