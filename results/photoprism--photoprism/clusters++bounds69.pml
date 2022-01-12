// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/photoprism/photoprism/blob//pkg/clusters/common.go#L69
#define def_var_l77  ?? // mand l line 77
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_bounds690 = [1] of {int};
	run bounds69(child_bounds690);
	run receiver(child_bounds690)
stop_process:skip
}

proctype bounds69(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Anonymousbounds87870 = [1] of {int};
	Wgdef wg;
	int var_l = def_var_l77; // mand var_l
	run wgMonitor(wg);
	wg.update!var_l;
		for(i : 0.. var_l-1) {
		for20: skip;
		run Anonymousbounds8787(wg,child_Anonymousbounds87870);
		run receiver(child_Anonymousbounds87870);
		for20_end: skip
	};
	for20_exit: skip;
	wg.wait?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Anonymousbounds8787(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_data = -2; // opt var_data
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

