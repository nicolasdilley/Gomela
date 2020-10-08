
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example487246790/distributed/driver/driver.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int fcd_taskGroups = 5;
	int i;
	int tasks = 5;
	Wgdef wg;
	int tasks[len-1]_OutputShards = 5;
	int touchedAgents = 5;
	bool state = false;
	run wgMonitor(wg);
		for(i : 1.. fcd_taskGroups) {
for10:		wg.Add!1;
		run Anonymous0(wg)
	};
	wg.Wait?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. fcd_taskGroups) {
for20:				for(i : 1.. tasks[len-1]_OutputShards) {
for21:
		}
	};
		for(i : 1.. touchedAgents) {
for30:		wg.Add!1;
		run Anonymous1(wg)
	};
	wg.Wait?0
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	wg.Add!-1;
stop_process:
}
proctype Anonymous1(Wgdef wg) {
	bool closed; 
	int i;
	wg.Add!-1;
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
