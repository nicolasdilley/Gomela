#define pods127  -2
#define gcTerminated_deleteCount  0

// https://github.com/kubernetes/kubernetes/blob/master/pkg/controller/podgc/gc_controller.go#L127
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_gcTerminated1270 = [1] of {int};
	run gcTerminated127(pods127,child_gcTerminated1270)
stop_process:skip
}

proctype gcTerminated127(int pods;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousgcTerminated1481480 = [1] of {int};
	Wgdef wait;
	int deleteCount = gcTerminated_deleteCount;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wait);
		for(i : 0.. deleteCount-1) {
		for20: skip;
		wait.update!1;
		run AnonymousgcTerminated148148(wait,child_AnonymousgcTerminated1481480);
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
	stop_process: skip;
		wait.update!-1;
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

