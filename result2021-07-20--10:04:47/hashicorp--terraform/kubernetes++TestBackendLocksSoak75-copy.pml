// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/terraform/blob/c63c06d3c4d09a1bf1a1adc20216503e0cc2f881/backend/remote-state/kubernetes/backend_test.go#L75
#define var_lockers97  3 // mand lockers line 97
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestBackendLocksSoak750 = [1] of {int};
	run TestBackendLocksSoak75(child_TestBackendLocksSoak750);
	run receiver(child_TestBackendLocksSoak750)
stop_process:skip
}

proctype TestBackendLocksSoak75(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestBackendLocksSoak99990 = [1] of {int};
	Wgdef wg;
	int var_lockers = var_lockers97; // mand var_lockers
	int var_clientCountclientCount = -2; // opt var_clientCountclientCount
	run wgMonitor(wg);
		for(i : 0.. var_lockers-1) {
		for20: skip;
		wg.update!1;
		run AnonymousTestBackendLocksSoak9999(wg,child_AnonymousTestBackendLocksSoak99990);
		run receiver(child_AnonymousTestBackendLocksSoak99990);
		for20_end: skip
	};
	for20_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestBackendLocksSoak9999(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_lockAttemptslockAttempts = -2; // opt var_lockAttemptslockAttempts
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

