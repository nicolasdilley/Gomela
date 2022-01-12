// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/tal-tech/go-zero/blob//core/syncx/spinlock_test.go#L30
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestSpinLockRace300 = [1] of {int};
	run TestSpinLockRace30(child_TestSpinLockRace300);
	run receiver(child_TestSpinLockRace300)
stop_process:skip
}

proctype TestSpinLockRace30(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestSpinLockRace35330 = [1] of {int};
	Wgdef wait;
	run wgMonitor(wait);
	wait.update!1;
	run AnonymousTestSpinLockRace3533(wait,child_AnonymousTestSpinLockRace35330);
	run receiver(child_AnonymousTestSpinLockRace35330);
	wait.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestSpinLockRace3533(Wgdef wait;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wait.update!-1;
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

