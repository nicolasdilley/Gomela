#define DoParallelContainerStartBenchmark_routineNumber  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example354162558/docker-micro-benchmark/helpers/docker_helpers.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	int routineNumber = DoParallelContainerStartBenchmark_routineNumber;
	bool state = false;
	run wgMonitor(wg);
	wg.Add!routineNumber;
for10_exit:	wg.Wait?0;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
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
for11_exit:	wg.Add!-1;
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
