// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/inputs/beanstalkd/beanstalkd.go#L36
#define def_var_tubes62  ?? // mand tubes line 62
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_Gather360 = [1] of {int};
	run Gather36(child_Gather360);
	run receiver(child_Gather360)
stop_process:skip
}

proctype Gather36(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousGather64641 = [1] of {int};
	chan child_AnonymousGather54510 = [1] of {int};
	Wgdef wg;
	int var_tubes = def_var_tubes62; // mand var_tubes
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
	wg.update!1;
	run AnonymousGather5451(wg,child_AnonymousGather54510);
	run receiver(child_AnonymousGather54510);
		for(i : 0.. var_tubes-1) {
		for10: skip;
		wg.update!1;
		run AnonymousGather6464(wg,child_AnonymousGather64641);
		run receiver(child_AnonymousGather64641);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousGather5451(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousGather6464(Wgdef wg;chan child) {
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

