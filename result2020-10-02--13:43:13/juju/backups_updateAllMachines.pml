
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example529324227/state/backups/restore.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	Wgdef machineUpdating;
	bool state = false;
	run wgMonitor(machineUpdating);
		for(i : 1.. machines) {
for10:		machineUpdating.Add!1;
		run Anonymous0(machineUpdating)
	};
	machineUpdating.Wait?0;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef machineUpdating) {
	bool closed; 
	int i;
	machineUpdating.Add!-1;
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
