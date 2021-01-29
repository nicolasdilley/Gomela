#define TraverseBfs_K  1
#define ub_for23_1  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example215173286/weed/pb/filer_pb/filer_client_bfs.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef jobQueueWg;
	int num_msgs = 0;
	bool state = false;
	int i;
	int K = TraverseBfs_K;
	run wgMonitor(jobQueueWg);
	jobQueueWg.Add!1;
		for(i : 0.. K-1) {
		for10: skip;
		run go_Anonymous0(jobQueueWg);
		for10_end: skip
	};
	for10_exit: skip;
	jobQueueWg.Wait?0;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Wgdef jobQueueWg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_filer_pbprocessOneDirectory0 = [0] of {int};
		for(i : 0.. ub_for23_1) {
		for11: skip;
		

		if
		:: true -> 
			break
		:: true;
		fi;
		

		if
		:: true -> 
			goto for11_end
		:: true;
		fi;
		run filer_pbprocessOneDirectory(jobQueueWg,child_filer_pbprocessOneDirectory0);
		child_filer_pbprocessOneDirectory0?0;
		jobQueueWg.Add!-1;
		for11_end: skip
	};
	for11_exit: skip;
	stop_process: skip
}
proctype filer_pbprocessOneDirectory(Wgdef jobQueueWg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
bool closed;
int i;
bool state;
do
	:: wg.Add?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.Add?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
	fi
od
}

