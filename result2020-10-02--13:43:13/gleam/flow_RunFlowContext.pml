
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example487246790/flow/runner.go
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
		for(i : 1.. fc_Steps) {
for10:		
		if
		:: true -> 
			wg.Add!1;
			run Anonymous1()
		:: true;
		fi
	};
	wg.Add!-1;
	child!0;
stop_process:
}
proctype Anonymous1() {
	bool closed; 
	int i;
stop_process:
}
proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
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
	od;
stop_process:
}
