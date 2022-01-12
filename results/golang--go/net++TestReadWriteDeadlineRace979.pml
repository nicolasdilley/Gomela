// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob//net/timeout_test.go#L979
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestReadWriteDeadlineRace9790 = [1] of {int};
	run TestReadWriteDeadlineRace979(child_TestReadWriteDeadlineRace9790);
	run receiver(child_TestReadWriteDeadlineRace9790)
stop_process:skip
}

proctype TestReadWriteDeadlineRace979(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestReadWriteDeadlineRace10289992 = [1] of {int};
	chan child_AnonymousTestReadWriteDeadlineRace10219991 = [1] of {int};
	chan child_AnonymousTestReadWriteDeadlineRace10019990 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
	wg.update!3;
	run AnonymousTestReadWriteDeadlineRace1001999(wg,child_AnonymousTestReadWriteDeadlineRace10019990);
	run receiver(child_AnonymousTestReadWriteDeadlineRace10019990);
	run AnonymousTestReadWriteDeadlineRace1021999(wg,child_AnonymousTestReadWriteDeadlineRace10219991);
	run receiver(child_AnonymousTestReadWriteDeadlineRace10219991);
	run AnonymousTestReadWriteDeadlineRace1028999(wg,child_AnonymousTestReadWriteDeadlineRace10289992);
	run receiver(child_AnonymousTestReadWriteDeadlineRace10289992);
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestReadWriteDeadlineRace1001999(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_N = -2; // opt var_N
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousTestReadWriteDeadlineRace1021999(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_N = -2; // opt var_N
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousTestReadWriteDeadlineRace1028999(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_N = -2; // opt var_N
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

