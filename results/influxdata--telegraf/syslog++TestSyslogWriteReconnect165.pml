// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/outputs/syslog/syslog_test.go#L165
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestSyslogWriteReconnect1650 = [1] of {int};
	run TestSyslogWriteReconnect165(child_TestSyslogWriteReconnect1650);
	run receiver(child_TestSyslogWriteReconnect1650)
stop_process:skip
}

proctype TestSyslogWriteReconnect165(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestSyslogWriteReconnect1851820 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
	wg.update!1;
	run AnonymousTestSyslogWriteReconnect185182(wg,child_AnonymousTestSyslogWriteReconnect1851820);
	run receiver(child_AnonymousTestSyslogWriteReconnect1851820);
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestSyslogWriteReconnect185182(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

