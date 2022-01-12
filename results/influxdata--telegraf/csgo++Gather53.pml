// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/inputs/csgo/csgo.go#L53
#define def_var_s_Servers57  ?? // mand s.Servers line 57
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_Gather530 = [1] of {int};
	run Gather53(child_Gather530);
	run receiver(child_Gather530)
stop_process:skip
}

proctype Gather53(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousGather59590 = [1] of {int};
	Wgdef wg;
	int var_s_Servers = def_var_s_Servers57; // mand var_s_Servers
	run wgMonitor(wg);
		for(i : 0.. var_s_Servers-1) {
		for10: skip;
		wg.update!1;
		run AnonymousGather5959(wg,child_AnonymousGather59590);
		run receiver(child_AnonymousGather59590);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousGather5959(Wgdef wg;chan child) {
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

