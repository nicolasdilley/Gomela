
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example117914275/flow/runner.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	chan child_rRunFlowAsync0 = [0] of {int};
	bool state = false;
	run wgMonitor(wg);
	wg.Add!1;
	run rRunFlowAsync(wg,child_rRunFlowAsync0);
	child_rRunFlowAsync0?0;
	wg.Wait?0
stop_process:}

proctype rRunFlowAsync(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
		for(i : 0.. fc_Steps-1) {
for10:		
		if
		:: true -> 
			wg.Add!1;
			run Anonymous1()
		:: true;
		fi
	};
stop_process:	wg.Add!-1;
	child!0
}
proctype Anonymous1() {
	bool closed; 
	int i;
	bool state;
stop_process:
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
