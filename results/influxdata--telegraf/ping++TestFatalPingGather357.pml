// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/inputs/ping/ping_test.go#L357
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestFatalPingGather3570 = [1] of {int};
	run TestFatalPingGather357(child_TestFatalPingGather3570);
	run receiver(child_TestFatalPingGather3570)
stop_process:skip
}

proctype TestFatalPingGather357(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Wgdef p_wg;
	run wgMonitor(p_wg);
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

