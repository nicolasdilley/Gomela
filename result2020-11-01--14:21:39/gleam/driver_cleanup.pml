#define cleanup_fcd_taskGroups 3
#define cleanup_tasks[len-1]_OutputShards 1
#define cleanup_tasks 1
#define cleanup_touchedAgents 1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example117914275/distributed/driver/driver.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int fcd_taskGroups = cleanup_fcd_taskGroups;
	int i;
	int tasks = cleanup_tasks;
	Wgdef wg;
	int tasks[len-1]_OutputShards = cleanup_tasks[len-1]_OutputShards;
	int touchedAgents = cleanup_touchedAgents;
	bool state = false;
	run wgMonitor(wg);
		for(i : 0.. fcd_taskGroups-1) {
for10:		wg.Add!1;
		run Anonymous0(wg)
	};
	wg.Wait?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 0.. fcd_taskGroups-1) {
for20:				for(i : 0.. tasks[len-1]_OutputShards-1) {
for21:
		}
	};
		for(i : 0.. touchedAgents-1) {
for30:		wg.Add!1;
		run Anonymous1(wg)
	};
	wg.Wait?0
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
stop_process:	wg.Add!-1
}
proctype Anonymous1(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
stop_process:	wg.Add!-1
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

