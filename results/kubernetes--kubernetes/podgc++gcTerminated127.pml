#define gcTerminated_deleteCount  3

// https://github.com/kubernetes/kubernetes/blob/d70ee902fddc682863a3cc4f0d8eac0223ebf70b/pkg/controller/podgc/gc_controller.go#L127
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wait;
	int num_msgs = 0;
	bool state = false;
	int i;
	int deleteCount = gcTerminated_deleteCount;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wait);
		for(i : 0.. deleteCount-1) {
		for20: skip;
		wait.Add!1;
		run go_Anonymous0(wait);
		for20_end: skip
	};
	for20_exit: skip;
	wait.Wait?0
stop_process:skip
}

proctype go_Anonymous0(Wgdef wait) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	wait.Add!-1
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
bool closed;
int i;
bool state;
do
	:: wg.Add?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.Add?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
	fi
od
}

