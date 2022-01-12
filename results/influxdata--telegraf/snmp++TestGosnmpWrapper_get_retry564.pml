// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/inputs/snmp/snmp_test.go#L564
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestGosnmpWrapper_get_retry5640 = [1] of {int};
	run TestGosnmpWrapper_get_retry564(child_TestGosnmpWrapper_get_retry5640);
	run receiver(child_TestGosnmpWrapper_get_retry5640)
stop_process:skip
}

proctype TestGosnmpWrapper_get_retry564(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestGosnmpWrapper_get_retry5775750 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
	wg.update!1;
	run AnonymousTestGosnmpWrapper_get_retry577575(wg,child_AnonymousTestGosnmpWrapper_get_retry5775750);
	run receiver(child_AnonymousTestGosnmpWrapper_get_retry5775750);
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestGosnmpWrapper_get_retry577575(Wgdef wg;chan child) {
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

