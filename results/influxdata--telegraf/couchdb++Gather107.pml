// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/inputs/couchdb/couchdb.go#L107
#define def_var_c_Hosts109  ?? // mand c.Hosts line 109
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_Gather1070 = [1] of {int};
	run Gather107(child_Gather1070);
	run receiver(child_Gather1070)
stop_process:skip
}

proctype Gather107(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousGather1111110 = [1] of {int};
	Wgdef wg;
	int var_c_Hosts = def_var_c_Hosts109; // mand var_c_Hosts
	run wgMonitor(wg);
		for(i : 0.. var_c_Hosts-1) {
		for10: skip;
		wg.update!1;
		run AnonymousGather111111(wg,child_AnonymousGather1111110);
		run receiver(child_AnonymousGather1111110);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousGather111111(Wgdef wg;chan child) {
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

