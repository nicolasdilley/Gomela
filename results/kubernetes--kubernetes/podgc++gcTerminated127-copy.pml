// num_comm_params=2
// num_mand_comm_params=1
// num_opt_comm_params=1

// git_link=https://github.com/kubernetes/kubernetes/blob//pkg/controller/podgc/gc_controller.go#L127
#define def_var_pods  -2 // opt pods line 127
#define def_var_deleteCount146  3 // mand deleteCount line 146
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_gcTerminated1270 = [1] of {int};
	run gcTerminated127(def_var_pods,child_gcTerminated1270);
	run receiver(child_gcTerminated1270)
stop_process:skip
}

proctype gcTerminated127(int var_pods;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousgcTerminated1481480 = [1] of {int};
	Wgdef wait;
	int var_deleteCount = def_var_deleteCount146; // mand var_deleteCount
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wait);
		for(i : 0.. var_deleteCount-1) {
		for20: skip;
		wait.update!1;
		run AnonymousgcTerminated148148(wait,child_AnonymousgcTerminated1481480);
		run receiver(child_AnonymousgcTerminated1481480);
		for20_end: skip
	};
	for20_exit: skip;
	wait.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousgcTerminated148148(Wgdef wait;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
		defer1: skip;
	wait.update!-1;
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

