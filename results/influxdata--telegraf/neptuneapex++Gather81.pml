// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/inputs/neptune_apex/neptune_apex.go#L81
#define def_var_n_Servers83  ?? // mand n.Servers line 83
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_Gather810 = [1] of {int};
	run Gather81(child_Gather810);
	run receiver(child_Gather810)
stop_process:skip
}

proctype Gather81(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousGather85850 = [1] of {int};
	Wgdef wg;
	int var_n_Servers = def_var_n_Servers83; // mand var_n_Servers
	run wgMonitor(wg);
		for(i : 0.. var_n_Servers-1) {
		for10: skip;
		wg.update!1;
		run AnonymousGather8585(wg,child_AnonymousGather85850);
		run receiver(child_AnonymousGather85850);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousGather8585(Wgdef wg;chan child) {
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

