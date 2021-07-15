
// https://github.com/ethereum/go-ethereum/blob/master/p2p/simulations/adapters/inproc_test.go#L140
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestNetPipeBidirections1400 = [1] of {int};
	run TestNetPipeBidirections140(child_TestNetPipeBidirections1400)
stop_process:skip
}

proctype TestNetPipeBidirections140(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestNetPipeBidirections1681501 = [1] of {int};
	chan child_AnonymousTestNetPipeBidirections1551500 = [1] of {int};
	Wgdef wg;
	int msgs = -2;
	run wgMonitor(wg);
	wg.update!1;
	run AnonymousTestNetPipeBidirections155150(wg,msgs,child_AnonymousTestNetPipeBidirections1551500);
	wg.update!1;
	run AnonymousTestNetPipeBidirections168150(wg,msgs,child_AnonymousTestNetPipeBidirections1681501);
	stop_process: skip;
		wg.wait?0;
	child!0
}
proctype AnonymousTestNetPipeBidirections155150(Wgdef wg;int msgs;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
		wg.update!-1;
	child!0
}
proctype AnonymousTestNetPipeBidirections168150(Wgdef wg;int msgs;chan child) {
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

