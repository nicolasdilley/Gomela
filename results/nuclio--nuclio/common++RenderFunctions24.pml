#define RenderFunctions_functions  3

// https://github.com/nuclio/nuclio/blob/72501aefe67e58c915680d0d457006424076f081/pkg/nuctl/command/common/renderers.go#L24
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef waitGroup;
	int num_msgs = 0;
	bool state = false;
	int i;
	int functions = RenderFunctions_functions;
	run wgMonitor(waitGroup);
	waitGroup.Add!functions;
		for(i : 0.. functions-1) {
		for10: skip;
		run go_Anonymous0(waitGroup);
		for10_end: skip
	};
	for10_exit: skip;
	waitGroup.Wait?0;
	

	if
	:: true;
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Wgdef waitGroup) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	waitGroup.Add!-1;
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

