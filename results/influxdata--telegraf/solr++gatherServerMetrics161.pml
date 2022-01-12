// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/inputs/solr/solr.go#L161
#define def_var_cores170  ?? // mand cores line 170
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_gatherServerMetrics1610 = [1] of {int};
	run gatherServerMetrics161(child_gatherServerMetrics1610);
	run receiver(child_gatherServerMetrics1610)
stop_process:skip
}

proctype gatherServerMetrics161(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousgatherServerMetrics1721720 = [1] of {int};
	Wgdef wg;
	int var_cores = def_var_cores170; // mand var_cores
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
	wg.update!var_cores;
		for(i : 0.. var_cores-1) {
		for10: skip;
		run AnonymousgatherServerMetrics172172(wg,child_AnonymousgatherServerMetrics1721720);
		run receiver(child_AnonymousgatherServerMetrics1721720);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousgatherServerMetrics172172(Wgdef wg;chan child) {
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

