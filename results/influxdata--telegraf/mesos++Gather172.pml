// num_comm_params=2
// num_mand_comm_params=2
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/inputs/mesos/mesos.go#L172
#define def_var_m_masterURLs183  ?? // mand m.masterURLs line 183
#define def_var_m_slaveURLs191  ?? // mand m.slaveURLs line 191
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_Gather1720 = [1] of {int};
	run Gather172(child_Gather1720);
	run receiver(child_Gather1720)
stop_process:skip
}

proctype Gather172(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousGather1931932 = [1] of {int};
	chan child_AnonymousGather1851850 = [1] of {int};
	Wgdef wg;
	int var_m_slaveURLs = def_var_m_slaveURLs191; // mand var_m_slaveURLs
	int var_m_masterURLs = def_var_m_masterURLs183; // mand var_m_masterURLs
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	run wgMonitor(wg);
		for(i : 0.. var_m_masterURLs-1) {
		for10: skip;
		wg.update!1;
		run AnonymousGather185185(wg,child_AnonymousGather1851850);
		run receiver(child_AnonymousGather1851850);
		for10_end: skip
	};
	for10_exit: skip;
		for(i : 0.. var_m_slaveURLs-1) {
		for20: skip;
		wg.update!1;
		run AnonymousGather193193(wg,child_AnonymousGather1931932);
		run receiver(child_AnonymousGather1931932);
		for20_end: skip
	};
	for20_exit: skip;
	wg.wait?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousGather185185(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousGather193193(Wgdef wg;chan child) {
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

