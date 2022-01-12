// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//msp/cache/cache_test.go#L103
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestDeserializeIdentity1030 = [1] of {int};
	run TestDeserializeIdentity103(child_TestDeserializeIdentity1030);
	run receiver(child_TestDeserializeIdentity1030)
stop_process:skip
}

proctype TestDeserializeIdentity103(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestDeserializeIdentity1241240 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
	wg.update!100;
		for(i : 0.. 100-1) {
		for10: skip;
		run AnonymousTestDeserializeIdentity124124(wg,child_AnonymousTestDeserializeIdentity1241240);
		run receiver(child_AnonymousTestDeserializeIdentity1241240);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestDeserializeIdentity124124(Wgdef wg;chan child) {
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

