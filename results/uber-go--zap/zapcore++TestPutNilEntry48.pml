
// https://github.com/uber-go/zap/blob/master/zapcore/entry_test.go#L48
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestPutNilEntry480 = [1] of {int};
	run TestPutNilEntry48(child_TestPutNilEntry480)
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
	run AnonymousTestPutNilEntry6050(wg,child_AnonymousTestPutNilEntry60501);
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestPutNilEntry5350(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
		wg.update!-1;
	child!0
}
proctype AnonymousTestPutNilEntry6050(Wgdef wg;chan child) {
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

