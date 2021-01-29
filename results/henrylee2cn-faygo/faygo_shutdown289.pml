#define shutdown_frame_servers  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example817818586/framework.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef count;
	int num_msgs = 0;
	bool state = false;
	int i;
	int frame_servers = shutdown_frame_servers;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(count);
		for(i : 0.. frame_servers-1) {
		for10: skip;
		count.Add!1;
		run go_Anonymous0(count);
		for10_end: skip
	};
	for10_exit: skip;
	count.Wait?0;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Wgdef count) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	count.Add!-1;
	stop_process: skip
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

