
// https://github.com/kubernetes/kubernetes/blob/d70ee902fddc682863a3cc4f0d8eac0223ebf70b/test/integration/deployment/util.go#L241
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	run wgMonitor(wg);
	wg.Add!1;
	run go_markUpdatedPodsReady(wg);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	wg.Wait?0
stop_process:skip
}

proctype go_markUpdatedPodsReady(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	wg.Add!-1
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

