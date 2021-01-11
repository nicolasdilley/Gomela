
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example516331819/executor/executor.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_ProcessWithWaitGroup0 = [0] of {int};
	Wgdef wg;
	bool state = false;
	int i;
	run wgMonitor(wg);
	run ProcessWithWaitGroup(wg,child_ProcessWithWaitGroup0);
	child_ProcessWithWaitGroup0?0;
	goto stop_process
stop_process:skip
}

proctype ProcessWithWaitGroup(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	wg.Add!1;
	stop_process: skip;
	child!0
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

