#define describeServices_batches  3

// https://github.com/weaveworks/scope/blob/9aa9b1ae70bc40a765324152debf82e0ae0e2fce/probe/awsecs/client.go#L190
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef group;
	int num_msgs = 0;
	bool state = false;
	int i;
	int batches = describeServices_batches;
	run wgMonitor(group);
		for(i : 0.. batches-1) {
		for20: skip;
		group.Add!1;
		run go_Anonymous0(group);
		for20_end: skip
	};
	for20_exit: skip;
	group.Wait?0
stop_process:skip
}

proctype go_Anonymous0(Wgdef group) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	group.Add!-1
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

