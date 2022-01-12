// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/outputs/bigquery/bigquery.go#L109
#define def_var_groupedMetrics114  ?? // mand groupedMetrics line 114
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_Write1090 = [1] of {int};
	run Write109(child_Write1090);
	run receiver(child_Write1090)
stop_process:skip
}

proctype Write109(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousWrite1161160 = [1] of {int};
	Wgdef wg;
	int var_groupedMetrics = def_var_groupedMetrics114; // mand var_groupedMetrics
	run wgMonitor(wg);
		for(i : 0.. var_groupedMetrics-1) {
		for10: skip;
		wg.update!1;
		run AnonymousWrite116116(wg,child_AnonymousWrite1161160);
		run receiver(child_AnonymousWrite1161160);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousWrite116116(Wgdef wg;chan child) {
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

