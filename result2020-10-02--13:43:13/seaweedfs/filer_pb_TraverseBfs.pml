#define lb_for23_0  -1
#define ub_for23_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example417746801/weed/pb/filer_pb/filer_client_bfs.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef jobQueueWg;
	int i;
	int K = 5;
	bool state = false;
	run wgMonitor(jobQueueWg);
	jobQueueWg.Add!1;
		for(i : 0.. K-1) {
for10:		run Anonymous0(jobQueueWg)
	};
for10_exit:	jobQueueWg.Wait?0;
	goto stop_process
stop_process:}

proctype filer_pbprocessOneDirectory(Wgdef jobQueueWg;chan child) {
	bool closed; 
	int i;
	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous0(Wgdef jobQueueWg) {
	bool closed; 
	int i;
	do
	:: true -> 
for11:		
		if
		:: true -> 
			break
		:: true;
		fi;
		chan child_filer_pbprocessOneDirectory0 = [0] of {int};
		run filer_pbprocessOneDirectory(jobQueueWg,child_filer_pbprocessOneDirectory0);
		child_filer_pbprocessOneDirectory0?0;
		jobQueueWg.Add!-1
	od;
for11_exit:stop_process:
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
