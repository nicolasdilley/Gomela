// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/grafana/loki/blob/aa544a9dffdb8e78f7d7ed8edafce466d333b0a8/pkg/storage/util_test.go#L194
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_GetChunkRefs1940 = [1] of {int};
	run GetChunkRefs194(child_GetChunkRefs1940);
	run receiver(child_GetChunkRefs1940)
stop_process:skip
}

proctype GetChunkRefs194(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Wgdef f_wait;
	int var_m_chunks = -2; // opt var_m_chunks
	run wgMonitor(f_wait);
	goto stop_process;
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

