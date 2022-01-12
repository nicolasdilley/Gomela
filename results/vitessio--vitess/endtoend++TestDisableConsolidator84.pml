// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/vttablet/endtoend/config_test.go#L84
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestDisableConsolidator840 = [1] of {int};
	run TestDisableConsolidator84(child_TestDisableConsolidator840);
	run receiver(child_TestDisableConsolidator840)
stop_process:skip
}

proctype TestDisableConsolidator84(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestDisableConsolidator1091033 = [1] of {int};
	chan child_AnonymousTestDisableConsolidator105872 = [1] of {int};
	Wgdef wg2;
	chan child_AnonymousTestDisableConsolidator93871 = [1] of {int};
	chan child_AnonymousTestDisableConsolidator89870 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
	wg.update!2;
	run AnonymousTestDisableConsolidator8987(wg,child_AnonymousTestDisableConsolidator89870);
	run receiver(child_AnonymousTestDisableConsolidator89870);
	run AnonymousTestDisableConsolidator9387(wg,child_AnonymousTestDisableConsolidator93871);
	run receiver(child_AnonymousTestDisableConsolidator93871);
	wg.wait?0;
	run wgMonitor(wg2);
	wg2.update!2;
	run AnonymousTestDisableConsolidator10587(wg,wg2,child_AnonymousTestDisableConsolidator105872);
	run receiver(child_AnonymousTestDisableConsolidator105872);
	run AnonymousTestDisableConsolidator109103(wg2,wg,child_AnonymousTestDisableConsolidator1091033);
	run receiver(child_AnonymousTestDisableConsolidator1091033);
	wg2.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestDisableConsolidator8987(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousTestDisableConsolidator9387(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousTestDisableConsolidator10587(Wgdef wg;Wgdef wg2;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg2.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousTestDisableConsolidator109103(Wgdef wg2;Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg2.update!-1;
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

