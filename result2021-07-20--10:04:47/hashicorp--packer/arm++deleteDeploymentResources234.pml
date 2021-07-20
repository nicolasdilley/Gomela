// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/packer/blob/a9c2283ee589b203c0ce16174a5747b7d2053d61/builder/azure/arm/step_deploy_template.go#L234
#define var_resources264  ?? // mand resources line 264
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_deleteDeploymentResources2340 = [1] of {int};
	run deleteDeploymentResources234(child_deleteDeploymentResources2340);
	run receiver(child_deleteDeploymentResources2340)
stop_process:skip
}

proctype deleteDeploymentResources234(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousdeleteDeploymentResources2672670 = [1] of {int};
	Wgdef wg;
	int var_resources = var_resources264; // mand var_resources
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
	wg.update!var_resources;
		for(i : 0.. var_resources-1) {
		for20: skip;
		run AnonymousdeleteDeploymentResources267267(wg,child_AnonymousdeleteDeploymentResources2672670);
		run receiver(child_AnonymousdeleteDeploymentResources2672670);
		for20_end: skip
	};
	for20_exit: skip;
	wg.wait?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousdeleteDeploymentResources267267(Wgdef wg;chan child) {
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

