// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/prometheus/prometheus/blob/27b78c336e436e9eed8b55ab0b162b888ec641d8/tsdb/db_test.go#L2745
#define def_var_chks2768  ?? // mand chks line 2768
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestChunkReader_ConcurrentReads27450 = [1] of {int};
	run TestChunkReader_ConcurrentReads2745(child_TestChunkReader_ConcurrentReads27450);
	run receiver(child_TestChunkReader_ConcurrentReads27450)
stop_process:skip
}

proctype TestChunkReader_ConcurrentReads2745(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestChunkReader_ConcurrentReads277127710 = [1] of {int};
	Wgdef wg;
	int var_chks = def_var_chks2768; // mand var_chks
	run wgMonitor(wg);
		for(i : 0.. var_chks-1) {
		for10: skip;
				for(i : 0.. 100-1) {
			for11: skip;
			wg.update!1;
			run AnonymousTestChunkReader_ConcurrentReads27712771(wg,child_AnonymousTestChunkReader_ConcurrentReads277127710);
			run receiver(child_AnonymousTestChunkReader_ConcurrentReads277127710);
			for11_end: skip
		};
		for11_exit: skip;
		wg.wait?0;
		for10_end: skip
	};
	for10_exit: skip;
	stop_process: skip;
	child!0
}
proctype AnonymousTestChunkReader_ConcurrentReads27712771(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
		defer1: skip;
	wg.update!-1;
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

