// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/inputs/powerdns_recursor/powerdns_recursor_test.go#L99
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestPowerdnsRecursorGeneratesMetrics990 = [1] of {int};
	run TestPowerdnsRecursorGeneratesMetrics99(child_TestPowerdnsRecursorGeneratesMetrics990);
	run receiver(child_TestPowerdnsRecursorGeneratesMetrics990)
stop_process:skip
}

proctype TestPowerdnsRecursorGeneratesMetrics99(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestPowerdnsRecursorGeneratesMetrics1121100 = [1] of {int};
	Wgdef wg;
	int var_intMetrics = -2; // opt var_intMetrics
	run wgMonitor(wg);
	wg.update!1;
	run AnonymousTestPowerdnsRecursorGeneratesMetrics112110(wg,child_AnonymousTestPowerdnsRecursorGeneratesMetrics1121100);
	run receiver(child_AnonymousTestPowerdnsRecursorGeneratesMetrics1121100);
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestPowerdnsRecursorGeneratesMetrics112110(Wgdef wg;chan child) {
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

