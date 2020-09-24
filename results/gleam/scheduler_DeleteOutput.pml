#define tasks[len-1]_OutputShards  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example880849486/distributed/driver/scheduler/scheduler_dataset_shard.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int tasks[len-1]_OutputShards = 5;
	Wgdef wg;
	int tasks = 5;
	bool state = false;
	run wgMonitor(wg);
		for(i : 1.. tasks[len-1]_OutputShards) {
for10:		wg.Add!1;
		run Anonymous0(wg)
	};
	wg.Wait?0
stop_process:}

proctype Anonymous0(Wgdef wg) {
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
