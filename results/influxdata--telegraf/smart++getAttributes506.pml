// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/inputs/smart/smart.go#L506
#define def_var_devices  ?? // mand devices line 506
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_getAttributes5060 = [1] of {int};
	run getAttributes506(def_var_devices,child_getAttributes5060);
	run receiver(child_getAttributes5060)
stop_process:skip
}

proctype getAttributes506(int var_devices;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_gatherDisk6440 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
	wg.update!var_devices;
		for(i : 0.. var_devices-1) {
		for10: skip;
		run gatherDisk644(wg,child_gatherDisk6440);
		run receiver(child_gatherDisk6440);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype gatherDisk644(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_keys = -2; // opt var_keys
	

	if
	:: true -> 
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

