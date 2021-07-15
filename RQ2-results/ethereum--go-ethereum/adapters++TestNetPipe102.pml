
// https://github.com/ethereum/go-ethereum/blob/master/p2p/simulations/adapters/inproc_test.go#L102
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestNetPipe1020 = [1] of {int};
	run TestNetPipe102(child_TestNetPipe1020)
stop_process:skip
}

proctype TestNetPipe102(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestNetPipe1151100 = [1] of {int};
	Wgdef wg;
	int msgs = -2;
	run wgMonitor(wg);
	wg.update!1;
	run AnonymousTestNetPipe115110(wg,msgs,child_AnonymousTestNetPipe1151100);
	stop_process: skip;
		wg.wait?0;
	child!0
}
proctype AnonymousTestNetPipe115110(Wgdef wg;int msgs;chan child) {
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

