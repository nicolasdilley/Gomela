// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/uber-go/zap/blob/7b21229fb3f063275f4f169f8a79ad30aa001c51/zapcore/entry_test.go#L48
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestPutNilEntry480 = [1] of {int};
	run TestPutNilEntry48(child_TestPutNilEntry480);
	run receiver(child_TestPutNilEntry480)
stop_process:skip
}

proctype TestPutNilEntry48(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestPutNilEntry60501 = [1] of {int};
	chan child_AnonymousTestPutNilEntry53500 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
	wg.update!2;
	run AnonymousTestPutNilEntry5350(wg,child_AnonymousTestPutNilEntry53500);
	run receiver(child_AnonymousTestPutNilEntry53500);
	run AnonymousTestPutNilEntry6050(wg,child_AnonymousTestPutNilEntry60501);
	run receiver(child_AnonymousTestPutNilEntry60501);
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestPutNilEntry5350(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousTestPutNilEntry6050(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

