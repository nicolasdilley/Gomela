// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/inputs/mongodb/mongodb.go#L161
#define def_var_m_clients163  ?? // mand m.clients line 163
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_Gather1610 = [1] of {int};
	run Gather161(child_Gather1610);
	run receiver(child_Gather1610)
stop_process:skip
}

proctype Gather161(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousGather1651650 = [1] of {int};
	Wgdef wg;
	int var_m_clients = def_var_m_clients163; // mand var_m_clients
	run wgMonitor(wg);
		for(i : 0.. var_m_clients-1) {
		for10: skip;
		wg.update!1;
		run AnonymousGather165165(wg,child_AnonymousGather1651650);
		run receiver(child_AnonymousGather1651650);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousGather165165(Wgdef wg;chan child) {
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

