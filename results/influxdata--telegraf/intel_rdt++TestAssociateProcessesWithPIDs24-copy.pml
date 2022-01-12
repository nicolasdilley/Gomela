// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/inputs/intel_rdt/intel_rdt_test.go#L24
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestAssociateProcessesWithPIDs240 = [1] of {int};
	run TestAssociateProcessesWithPIDs24(child_TestAssociateProcessesWithPIDs240);
	run receiver(child_TestAssociateProcessesWithPIDs240)
stop_process:skip
}

proctype TestAssociateProcessesWithPIDs24(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_associateProcessesWithPIDs2182 = [1] of {int};
	chan child_associateProcessesWithPIDs2181 = [1] of {int};
	chan child_associateProcessesWithPIDs2180 = [1] of {int};
	Wgdef rdt_wg;
	run wgMonitor(rdt_wg);
	run associateProcessesWithPIDs218(rdt_wg,child_associateProcessesWithPIDs2180);
	child_associateProcessesWithPIDs2180?0;
	run associateProcessesWithPIDs218(rdt_wg,child_associateProcessesWithPIDs2181);
	child_associateProcessesWithPIDs2181?0;
	run associateProcessesWithPIDs218(rdt_wg,child_associateProcessesWithPIDs2182);
	child_associateProcessesWithPIDs2182?0;
	stop_process: skip;
	child!0
}
proctype associateProcessesWithPIDs218(Wgdef r_wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_mapProcessPIDs = -2; // opt var_mapProcessPIDs
	int var_availableProcesses = -2; // opt var_availableProcesses
	

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

