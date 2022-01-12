// num_comm_params=2
// num_mand_comm_params=2
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/inputs/dovecot/dovecot.go#L52
#define def_var_d_Servers66  ?? // mand d.Servers line 66
#define def_var_d_Filters67  ?? // mand d.Filters line 67
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_Gather520 = [1] of {int};
	run Gather52(child_Gather520);
	run receiver(child_Gather520)
stop_process:skip
}

proctype Gather52(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousGather69690 = [1] of {int};
	Wgdef wg;
	int var_d_Filters = def_var_d_Filters67; // mand var_d_Filters
	int var_d_Servers = def_var_d_Servers66; // mand var_d_Servers
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
		for(i : 0.. var_d_Servers-1) {
		for10: skip;
				for(i : 0.. var_d_Filters-1) {
			for11: skip;
			wg.update!1;
			run AnonymousGather6969(wg,child_AnonymousGather69690);
			run receiver(child_AnonymousGather69690);
			for11_end: skip
		};
		for11_exit: skip;
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousGather6969(Wgdef wg;chan child) {
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

