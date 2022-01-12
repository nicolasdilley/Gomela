// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/cache/ristretto/store_test.go#L58
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestStoreDel580 = [1] of {int};
	run TestStoreDel58(child_TestStoreDel580);
	run receiver(child_TestStoreDel580)
stop_process:skip
}

proctype TestStoreDel58(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Wgdef i_wg;
	run wgMonitor(i_wg);
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

