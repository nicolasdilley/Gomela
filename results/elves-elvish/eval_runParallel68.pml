#define runParallel_functions  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example958660458/pkg/eval/builtin_fn_flow.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef waitg;
	int num_msgs = 0;
	bool state = false;
	int i;
	int functions = runParallel_functions;
	run wgMonitor(waitg);
	waitg.Add!functions;
		for(i : 0.. functions-1) {
		for10: skip;
		run go_Anonymous0(waitg);
		for10_end: skip
	};
	for10_exit: skip;
	waitg.Wait?0;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Wgdef waitg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	waitg.Add!-1;
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
