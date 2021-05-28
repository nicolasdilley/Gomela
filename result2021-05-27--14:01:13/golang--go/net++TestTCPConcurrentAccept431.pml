// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/net/tcpsock_test.go#L431
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestTCPConcurrentAccept4310 = [1] of {int};
	run TestTCPConcurrentAccept431(child_TestTCPConcurrentAccept4310);
	run receiver(child_TestTCPConcurrentAccept4310)
stop_process:skip
}

proctype TestTCPConcurrentAccept431(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestTCPConcurrentAccept4414380 = [1] of {int};
	Wgdef wg;
	int attempts = -2; // opt attempts
	run wgMonitor(wg);
	wg.update!10;
		for(i : 0.. 10-1) {
		for10: skip;
		run AnonymousTestTCPConcurrentAccept441438(wg,child_AnonymousTestTCPConcurrentAccept4414380);
		run receiver(child_AnonymousTestTCPConcurrentAccept4414380);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
		stop_process: skip;
	stop_process: skip;
	child!0
}
proctype AnonymousTestTCPConcurrentAccept441438(Wgdef wg;chan child) {
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

