
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example247347044/executor/executor.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	chan child_pProcessWithWaitGroup0 = [0] of {int};
	bool state = false;
	run wgMonitor(wg);
	run pProcessWithWaitGroup(wg,child_pProcessWithWaitGroup0);
	child_pProcessWithWaitGroup0?0;
	goto stop_process
stop_process:}

proctype pProcessWithWaitGroup(Wgdef wg;chan child) {
	bool closed; 
	int i;
	wg.Add!1;
	child!0;
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
