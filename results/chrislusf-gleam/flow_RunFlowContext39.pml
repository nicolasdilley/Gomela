
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example698904740/flow/runner.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_RunFlowAsync0 = [0] of {int};
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	run wgMonitor(wg);
	wg.Add!1;
	run RunFlowAsync(wg,child_RunFlowAsync0);
	child_RunFlowAsync0?0;
	wg.Wait?0
stop_process:skip
}

proctype RunFlowAsync(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int fc_Steps = 1;
		for(i : 0.. fc_Steps-1) {
		for10: skip;
		

		if
		:: true -> 
			wg.Add!1
		:: true;
		fi;
		for10_end: skip
	};
	for10_exit: skip;
	stop_process: skip;
	wg.Add!-1;
	child!0
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

