#define DoParallelContainerStartBenchmark_routineNumber 0
#define DoParallelContainerStartBenchmark_latenciesTable 3
#define lb_for261_2  -1
#define ub_for261_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example415420627/docker-micro-benchmark/helpers/docker_helpers.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int routineNumber = DoParallelContainerStartBenchmark_routineNumber;
	Wgdef wg;
	int latenciesTable = DoParallelContainerStartBenchmark_latenciesTable;
	bool state = false;
	run wgMonitor(wg);
	wg.Add!routineNumber;
		for(i : 0.. routineNumber-1) {
for10:		run Anonymous0()
	};
for10_exit:	wg.Wait?0;
		for(i : 0.. latenciesTable-1) {
for20:
	};
	goto stop_process
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for11:		
		if
		:: true -> 
			break
		:: true;
		fi
	od;
for11_exit:stop_process:
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

