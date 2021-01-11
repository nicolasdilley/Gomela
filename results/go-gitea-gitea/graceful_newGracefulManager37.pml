#define newGracefulManager_numberOfServersToCreate  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example133053963/modules/graceful/manager_unix.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef manager_terminateWaitGroup;
	Wgdef manager_createServerWaitGroup;
	Wgdef manager_runningServerWaitGroup;
	bool state = false;
	int i;
	int numberOfServersToCreate = newGracefulManager_numberOfServersToCreate;
	run wgMonitor(manager_runningServerWaitGroup);
	run wgMonitor(manager_createServerWaitGroup);
	run wgMonitor(manager_terminateWaitGroup);
	manager_createServerWaitGroup.Add!numberOfServersToCreate;
	goto stop_process
stop_process:skip
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
end: if
		:: wg.Add?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
	fi
od
}

