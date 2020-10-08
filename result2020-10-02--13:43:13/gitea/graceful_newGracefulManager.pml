
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example343935019/modules/graceful/manager_unix.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef manager_terminateWaitGroup;
	Wgdef manager_runningServerWaitGroup;
	int i;
	Wgdef manager_createServerWaitGroup;
	int numberOfServersToCreate = 5;
	bool state = false;
	run wgMonitor(manager_runningServerWaitGroup);
	run wgMonitor(manager_createServerWaitGroup);
	run wgMonitor(manager_terminateWaitGroup);
	manager_createServerWaitGroup.Add!numberOfServersToCreate;
	goto stop_process
stop_process:}

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
