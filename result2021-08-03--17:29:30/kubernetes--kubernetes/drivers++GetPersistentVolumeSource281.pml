// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kubernetes/blob/0277cff2682d5a0d3c6fa2109f7f82e8db3f2ed8/test/e2e/storage/drivers/in_tree.go#L281
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_GetPersistentVolumeSource2810 = [1] of {int};
	run GetPersistentVolumeSource281(child_GetPersistentVolumeSource2810);
	run receiver(child_GetPersistentVolumeSource2810)
stop_process:skip
}

proctype GetPersistentVolumeSource281(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Wgdef gv_f_logsSizeWaitGroup;
	run wgMonitor(gv_f_logsSizeWaitGroup);
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

