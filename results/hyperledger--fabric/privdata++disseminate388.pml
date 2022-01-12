// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//gossip/privdata/distributor.go#L388
#define def_var_disseminationPlan  ?? // mand disseminationPlan line 388
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_disseminate3880 = [1] of {int};
	run disseminate388(def_var_disseminationPlan,child_disseminate3880);
	run receiver(child_disseminate3880)
stop_process:skip
}

proctype disseminate388(int var_disseminationPlan;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Anonymousdisseminate3943940 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
	wg.update!var_disseminationPlan;
		for(i : 0.. var_disseminationPlan-1) {
		for10: skip;
		run Anonymousdisseminate394394(wg,child_Anonymousdisseminate3943940);
		run receiver(child_Anonymousdisseminate3943940);
		for10_end: skip
	};
	for10_exit: skip;
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
proctype Anonymousdisseminate394394(Wgdef wg;chan child) {
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

