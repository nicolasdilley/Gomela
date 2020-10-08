
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example190109984/client/allocrunner/alloc_runner.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int ar_tasks = 5;
	Wgdef wg;
	int i;
		for(i : 1.. ar_tasks) {
for10:		break
	};
	run wgMonitor(wg);
		for(i : 1.. ar_tasks) {
for20:		wg.Add!1;
		run Anonymous0()
	};
	wg.Wait?0;
	goto stop_process
stop_process:}

proctype Anonymous0() {
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
