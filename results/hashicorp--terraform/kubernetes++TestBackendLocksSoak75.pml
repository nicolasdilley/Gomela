// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/terraform/blob//backend/remote-state/kubernetes/backend_test.go#L75
#define def_var_lockers97  ?? // mand lockers line 97
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
	int var_lockers = def_var_lockers97; // mand var_lockers
	int var_clientCount = -2; // opt var_clientCount
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
	int var_lockAttempts = -2; // opt var_lockAttempts
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

