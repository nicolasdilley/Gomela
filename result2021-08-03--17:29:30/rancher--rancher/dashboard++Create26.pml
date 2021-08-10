// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/rancher/rancher/blob/91a6f51f259acd5670ff167d6bcf1916da7406f1/pkg/crds/management/crds.go#L26
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_Create260 = [1] of {int};
	run Create26(child_Create260);
	run receiver(child_Create260)
stop_process:skip
}

proctype Create26(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Wgdef factory_wg;
	run wgMonitor(factory_wg);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
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

