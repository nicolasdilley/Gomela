// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/inputs/solr/solr.go#L141
#define def_var_s_Servers148  ?? // mand s.Servers line 148
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_Gather1410 = [1] of {int};
	run Gather141(child_Gather1410);
	run receiver(child_Gather1410)
stop_process:skip
}

proctype Gather141(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousGather1511510 = [1] of {int};
	Wgdef wg;
	int var_s_Servers = def_var_s_Servers148; // mand var_s_Servers
	run wgMonitor(wg);
	wg.update!var_s_Servers;
		for(i : 0.. var_s_Servers-1) {
		for10: skip;
		run AnonymousGather151151(wg,child_AnonymousGather1511510);
		run receiver(child_AnonymousGather1511510);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousGather151151(Wgdef wg;chan child) {
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

