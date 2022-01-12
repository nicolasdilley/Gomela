// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/vttablet/endtoend/config_test.go#L39
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestPoolSize390 = [1] of {int};
	run TestPoolSize39(child_TestPoolSize390);
	run receiver(child_TestPoolSize390)
stop_process:skip
}

proctype TestPoolSize39(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestPoolSize53461 = [1] of {int};
	chan child_AnonymousTestPoolSize48460 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
	wg.update!2;
	run AnonymousTestPoolSize4846(wg,child_AnonymousTestPoolSize48460);
	run receiver(child_AnonymousTestPoolSize48460);
	run AnonymousTestPoolSize5346(wg,child_AnonymousTestPoolSize53461);
	run receiver(child_AnonymousTestPoolSize53461);
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestPoolSize4846(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousTestPoolSize5346(Wgdef wg;chan child) {
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

