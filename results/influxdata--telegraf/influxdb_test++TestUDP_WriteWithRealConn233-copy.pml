// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/outputs/influxdb/udp_test.go#L233
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestUDP_WriteWithRealConn2330 = [1] of {int};
	run TestUDP_WriteWithRealConn233(child_TestUDP_WriteWithRealConn2330);
	run receiver(child_TestUDP_WriteWithRealConn2330)
stop_process:skip
}

proctype TestUDP_WriteWithRealConn233(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestUDP_WriteWithRealConn2452430 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
	wg.update!1;
	run AnonymousTestUDP_WriteWithRealConn245243(wg,child_AnonymousTestUDP_WriteWithRealConn2452430);
	run receiver(child_AnonymousTestUDP_WriteWithRealConn2452430);
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestUDP_WriteWithRealConn245243(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_metrics = -2; // opt var_metrics
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

