// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/outputs/socket_writer/socket_writer_test.go#L164
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestSocketWriter_Write_reconnect1640 = [1] of {int};
	run TestSocketWriter_Write_reconnect164(child_TestSocketWriter_Write_reconnect1640);
	run receiver(child_TestSocketWriter_Write_reconnect1640)
stop_process:skip
}

proctype TestSocketWriter_Write_reconnect164(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestSocketWriter_Write_reconnect1841810 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
	wg.update!1;
	run AnonymousTestSocketWriter_Write_reconnect184181(wg,child_AnonymousTestSocketWriter_Write_reconnect1841810);
	run receiver(child_AnonymousTestSocketWriter_Write_reconnect1841810);
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestSocketWriter_Write_reconnect184181(Wgdef wg;chan child) {
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

