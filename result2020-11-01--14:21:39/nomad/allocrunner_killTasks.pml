#define killTasks_ar_tasks 3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example960382288/client/allocrunner/alloc_runner.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int ar_tasks = killTasks_ar_tasks;
	Wgdef wg;
	int i;
		for(i : 0.. ar_tasks-1) {
for10:		break
	};
	run wgMonitor(wg);
		for(i : 0.. ar_tasks-1) {
for20:		wg.Add!1;
		run Anonymous0()
	};
	wg.Wait?0;
	goto stop_process
stop_process:}

proctype Anonymous0() {
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

