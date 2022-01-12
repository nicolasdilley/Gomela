// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/inputs/snmp/snmp_test.go#L300
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestGetSNMPConnectionTCP3000 = [1] of {int};
	run TestGetSNMPConnectionTCP300(child_TestGetSNMPConnectionTCP3000);
	run receiver(child_TestGetSNMPConnectionTCP3000)
stop_process:skip
}

proctype TestGetSNMPConnectionTCP300(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_stubTCPServer3220 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
	wg.update!1;
	run stubTCPServer322(wg,child_stubTCPServer3220);
	run receiver(child_stubTCPServer3220);
	wg.wait?0;
	wg.update!1;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype stubTCPServer322(Wgdef wg;chan child) {
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

