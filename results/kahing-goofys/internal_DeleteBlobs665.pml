#define DeleteBlobs_param_Items  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example327246016/internal/backend_azblob.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	int param_Items = DeleteBlobs_param_Items;
	run wgMonitor(wg);
		for(i : 0.. param_Items-1) {
		for10: skip;
		wg.Add!1;
		run go_Anonymous0(wg);
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		for10_end: skip
	};
	for10_exit: skip;
	goto stop_process;
	wg.Wait?0
stop_process:skip
}

proctype go_Anonymous0(Wgdef wg) {
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

