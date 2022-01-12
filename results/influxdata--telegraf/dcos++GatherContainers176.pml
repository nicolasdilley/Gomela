// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/inputs/dcos/dcos.go#L176
#define def_var_containers184  ?? // mand containers line 184
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_GatherContainers1760 = [1] of {int};
	run GatherContainers176(child_GatherContainers1760);
	run receiver(child_GatherContainers1760)
stop_process:skip
}

proctype GatherContainers176(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousGatherContainers2032031 = [1] of {int};
	chan child_AnonymousGatherContainers1871870 = [1] of {int};
	Wgdef wg;
	int var_containers = def_var_containers184; // mand var_containers
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
		for(i : 0.. var_containers-1) {
		for10: skip;
		

		if
		:: true -> 
			wg.update!1;
			run AnonymousGatherContainers187187(wg,child_AnonymousGatherContainers1871870);
			run receiver(child_AnonymousGatherContainers1871870)
		:: true;
		fi;
		

		if
		:: true -> 
			wg.update!1;
			run AnonymousGatherContainers203203(wg,child_AnonymousGatherContainers2032031);
			run receiver(child_AnonymousGatherContainers2032031)
		:: true;
		fi;
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousGatherContainers187187(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto defer1
		:: true;
		fi;
		goto defer1
	:: true;
	fi;
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousGatherContainers203203(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto defer1
		:: true;
		fi;
		goto defer1
	:: true;
	fi;
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

