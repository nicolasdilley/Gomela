// num_comm_params=2
// num_mand_comm_params=1
// num_opt_comm_params=1

// git_link=https://github.com/kubernetes/kubernetes/blob/0277cff2682d5a0d3c6fa2109f7f82e8db3f2ed8/test/e2e/storage/vsphere/nodemapper.go#L62
#define def_var_vSphereInstances  -2 // opt vSphereInstances line 62
#define def_var_nodeList_Items108  ?? // mand nodeList.Items line 108
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_GenerateNodeMap620 = [1] of {int};
	run GenerateNodeMap62(def_var_vSphereInstances,child_GenerateNodeMap620);
	run receiver(child_GenerateNodeMap620)
stop_process:skip
}

proctype GenerateNodeMap62(int var_vSphereInstances;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousGenerateNodeMap110680 = [1] of {int};
	Wgdef wg;
	int var_nodeList_Items = def_var_nodeList_Items108; // mand var_nodeList_Items
	int var_datacenters = -2; // opt var_datacenters
	int var_dcName = -2; // opt var_dcName
	run wgMonitor(wg);
		for(i : 0.. var_nodeList_Items-1) {
		for20: skip;
		run AnonymousGenerateNodeMap11068(wg,child_AnonymousGenerateNodeMap110680);
		run receiver(child_AnonymousGenerateNodeMap110680);
		wg.update!1;
		for20_end: skip
	};
	for20_exit: skip;
	wg.wait?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousGenerateNodeMap11068(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_queueChannel = -2; // opt var_queueChannel
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

