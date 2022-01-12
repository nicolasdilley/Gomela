// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/inputs/jolokia2/jolokia_agent.go#L60
#define def_var_ja_clients80  3 // mand ja.clients line 80
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_Gather600 = [1] of {int};
	run Gather60(child_Gather600);
	run receiver(child_Gather600)
stop_process:skip
}

proctype Gather60(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousGather82820 = [1] of {int};
	Wgdef wg;
	int var_ja_clients = def_var_ja_clients80; // mand var_ja_clients
	int var_ja_URLs = -2; // opt var_ja_URLs
	run wgMonitor(wg);
		for(i : 0.. var_ja_clients-1) {
		for20: skip;
		wg.update!1;
		run AnonymousGather8282(wg,child_AnonymousGather82820);
		run receiver(child_AnonymousGather82820);
		for20_end: skip
	};
	for20_exit: skip;
	wg.wait?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousGather8282(Wgdef wg;chan child) {
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

