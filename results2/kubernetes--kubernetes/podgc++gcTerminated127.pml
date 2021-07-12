// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kubernetes/blob/0277cff2682d5a0d3c6fa2109f7f82e8db3f2ed8/pkg/controller/podgc/gc_controller.go#L127
#define var_pods127  -2 // opt var_pods127
#define gcTerminated_deleteCount  ??
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_gcTerminated1270 = [1] of {int};
	run gcTerminated127(var_pods127,child_gcTerminated1270);
	run receiver(child_gcTerminated1270)
stop_process:skip
}

proctype gcTerminated127(int pods;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousgcTerminated1481480 = [1] of {int};
	Wgdef wait;
	int var_deleteCount = gcTerminated_deleteCount; // mand var_deleteCount
	

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

