// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/grafana/loki/blob/aa544a9dffdb8e78f7d7ed8edafce466d333b0a8/pkg/storage/batch_test.go#L1327
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestBuildHeapIterator13270 = [1] of {int};
	run TestBuildHeapIterator1327(child_TestBuildHeapIterator13270);
	run receiver(child_TestBuildHeapIterator13270)
stop_process:skip
}

proctype TestBuildHeapIterator1327(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Wgdef thirdChunk_Fetcher_wait;
	Wgdef secondChunk_Fetcher_wait;
	Wgdef firstChunk_Fetcher_wait;
	run wgMonitor(firstChunk_Fetcher_wait);
	run wgMonitor(secondChunk_Fetcher_wait);
	run wgMonitor(thirdChunk_Fetcher_wait);
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

proctype receiver(chan c) {
c?0
}

