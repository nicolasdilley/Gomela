// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/inputs/net_response/net_response_test.go#L232
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestUDPOK12320 = [1] of {int};
	run TestUDPOK1232(child_TestUDPOK12320);
	run receiver(child_TestUDPOK12320)
stop_process:skip
}

proctype TestUDPOK1232(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_UDPServer2770 = [1] of {int};
	Wgdef wg;
	int var_acc_Metrics = -2; // opt var_acc_Metrics
	run wgMonitor(wg);
	wg.update!1;
	run UDPServer277(wg,child_UDPServer2770);
	run receiver(child_UDPServer2770);
	wg.wait?0;
	wg.update!1;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype UDPServer277(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.update!-1;
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

