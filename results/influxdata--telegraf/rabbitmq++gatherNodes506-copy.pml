// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/inputs/rabbitmq/rabbitmq.go#L506
#define def_var_nodes523  1 // mand nodes line 523
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_gatherNodes5060 = [1] of {int};
	run gatherNodes506(child_gatherNodes5060);
	run receiver(child_gatherNodes5060)
stop_process:skip
}

proctype gatherNodes506(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousgatherNodes5255250 = [1] of {int};
	Wgdef wg;
	int var_nodes = def_var_nodes523; // mand var_nodes
	int var_allNodes = -2; // opt var_allNodes
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
		for(i : 0.. var_nodes-1) {
		for20: skip;
		wg.update!1;
		run AnonymousgatherNodes525525(wg,child_AnonymousgatherNodes5255250);
		run receiver(child_AnonymousgatherNodes5255250);
		for20_end: skip
	};
	for20_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousgatherNodes525525(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true;
		:: true;
		:: true;
		fi
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

