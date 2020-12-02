#define DeleteOutput_tasks[len-1]_OutputShards  0
#define DeleteOutput_tasks  1

// /tmp/clone-example115657414/distributed/driver/scheduler/scheduler_dataset_shard.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int tasks[len-1]_OutputShards = DeleteOutput_tasks[len-1]_OutputShards;
	Wgdef wg;
	int tasks = DeleteOutput_tasks;
	bool state = false;
	run wgMonitor(wg);
		for(i : 0.. tasks[len-1]_OutputShards-1) {
for10:		wg.Add!1;
		run Anonymous0(wg)
	};
	wg.Wait?0
stop_process:}

proctype Anonymous0(Wgdef wg) {
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
