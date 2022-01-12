// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/inputs/leofs/leofs.go#L163
#define def_var_l_Servers168  ?? // mand l.Servers line 168
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_Gather1630 = [1] of {int};
	run Gather163(child_Gather1630);
	run receiver(child_Gather1630)
stop_process:skip
}

proctype Gather163(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousGather1891890 = [1] of {int};
	Wgdef wg;
	int var_l_Servers = def_var_l_Servers168; // mand var_l_Servers
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
		for(i : 0.. var_l_Servers-1) {
		for10: skip;
		

		if
		:: true -> 
			goto for10_end
		:: true -> 
			

			if
			:: true -> 
				

				if
				:: true -> 
					goto for10_end
				fi
			:: true;
			fi
		fi;
		wg.update!1;
		run AnonymousGather189189(wg,child_AnonymousGather1891890);
		run receiver(child_AnonymousGather1891890);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousGather189189(Wgdef wg;chan child) {
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

