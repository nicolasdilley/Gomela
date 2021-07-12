// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/fyne-io/fyne/blob/9b5a176fe1dc80beae72a3074d0d5cd2b409637c/internal/driver/glfw/driver_test.go#L116
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestGoroutineID1160 = [1] of {int};
	run TestGoroutineID116(child_TestGoroutineID1160);
	run receiver(child_TestGoroutineID1160)
stop_process:skip
}

proctype TestGoroutineID116(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestGoroutineID1271211 = [1] of {int};
	chan child_AnonymousTestGoroutineID1231210 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
	wg.update!2;
	run AnonymousTestGoroutineID123121(wg,child_AnonymousTestGoroutineID1231210);
	run receiver(child_AnonymousTestGoroutineID1231210);
	run AnonymousTestGoroutineID127121(wg,child_AnonymousTestGoroutineID1271211);
	run receiver(child_AnonymousTestGoroutineID1271211);
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestGoroutineID123121(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousTestGoroutineID127121(Wgdef wg;chan child) {
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

