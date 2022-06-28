// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/inputs/net_response/net_response_test.go#L152
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestTCPOK21520 = [1] of {int};
	run TestTCPOK2152(child_TestTCPOK21520);
	run receiver(child_TestTCPOK21520)
stop_process:skip
}

proctype TestTCPOK2152(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_TCPServer2890 = [1] of {int};
	Wgdef wg;
	int var_acc_Metrics = -2; // opt var_acc_Metrics
	run wgMonitor(wg);
	wg.update!1;
	run TCPServer289(wg,child_TCPServer2890);
	run receiver(child_TCPServer2890);
	wg.wait?0;
	wg.update!1;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype TCPServer289(Wgdef wg;chan child) {
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
