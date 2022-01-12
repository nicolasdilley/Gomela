// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/inputs/aliyuncms/aliyuncms_test.go#L202
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestUpdateWindow2020 = [1] of {int};
	run TestUpdateWindow202(child_TestUpdateWindow2020);
	run receiver(child_TestUpdateWindow2020)
stop_process:skip
}

proctype TestUpdateWindow202(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_updateWindow3481 = [1] of {int};
	chan child_updateWindow3480 = [1] of {int};
	Wgdef plugin_dt_wg;
	run wgMonitor(plugin_dt_wg);
	run updateWindow348(plugin_dt_wg,child_updateWindow3480);
	child_updateWindow3480?0;
	run updateWindow348(plugin_dt_wg,child_updateWindow3481);
	child_updateWindow3481?0;
	stop_process: skip;
	child!0
}
proctype updateWindow348(Wgdef s_dt_wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

