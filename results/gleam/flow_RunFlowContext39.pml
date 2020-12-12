
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example218494222/flow/runner.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	chan child_RunFlowAsync0 = [0] of {int};
	bool state = false;
	run wgMonitor(wg);
	wg.Add!1;
	run RunFlowAsync(wg,child_RunFlowAsync0);
	child_RunFlowAsync0?0;
	wg.Wait?0
stop_process:}

proctype RunFlowAsync(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int fc_Steps = ??;
stop_process:	child!0
}
proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: wg.Add?i -> 
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 -> 
end:		
		if
		:: wg.Add?i -> 
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
		fi
	od
}
