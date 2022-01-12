// num_comm_params=2
// num_mand_comm_params=2
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/inputs/dns_query/dns_query.go#L72
#define def_var_d_Domains76  ?? // mand d.Domains line 76
#define def_var_d_Servers77  ?? // mand d.Servers line 77
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_Gather720 = [1] of {int};
	run Gather72(child_Gather720);
	run receiver(child_Gather720)
stop_process:skip
}

proctype Gather72(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousGather79790 = [1] of {int};
	Wgdef wg;
	int var_d_Servers = def_var_d_Servers77; // mand var_d_Servers
	int var_d_Domains = def_var_d_Domains76; // mand var_d_Domains
	run wgMonitor(wg);
		for(i : 0.. var_d_Domains-1) {
		for10: skip;
				for(i : 0.. var_d_Servers-1) {
			for11: skip;
			wg.update!1;
			run AnonymousGather7979(wg,child_AnonymousGather79790);
			run receiver(child_AnonymousGather79790);
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
proctype AnonymousGather7979(Wgdef wg;chan child) {
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

