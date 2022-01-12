// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/inputs/ipmi_sensor/ipmi.go#L99
#define def_var_m_Servers106  ?? // mand m.Servers line 106
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_Gather990 = [1] of {int};
	run Gather99(child_Gather990);
	run receiver(child_Gather990)
stop_process:skip
}

proctype Gather99(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousGather1081080 = [1] of {int};
	Wgdef wg;
	int var_m_Servers = def_var_m_Servers106; // mand var_m_Servers
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run wgMonitor(wg);
				for(i : 0.. var_m_Servers-1) {
			for10: skip;
			wg.update!1;
			run AnonymousGather108108(wg,child_AnonymousGather1081080);
			run receiver(child_AnonymousGather1081080);
			for10_end: skip
		};
		for10_exit: skip;
		wg.wait?0
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousGather108108(Wgdef wg;chan child) {
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

