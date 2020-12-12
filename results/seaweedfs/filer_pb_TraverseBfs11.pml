#define TraverseBfs_K  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example102359220/weed/pb/filer_pb/filer_client_bfs.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef jobQueueWg;
	int i;
	int K = TraverseBfs_K;
	bool state = false;
	run wgMonitor(jobQueueWg);
	jobQueueWg.Add!1;
for10_exit:	jobQueueWg.Wait?0;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef jobQueueWg) {
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
