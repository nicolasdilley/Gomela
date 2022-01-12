// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob//bytes/reader_test.go#L117
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestEmptyReaderConcurrent1170 = [1] of {int};
	run TestEmptyReaderConcurrent117(child_TestEmptyReaderConcurrent1170);
	run receiver(child_TestEmptyReaderConcurrent1170)
stop_process:skip
}

proctype TestEmptyReaderConcurrent117(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestEmptyReaderConcurrent1301221 = [1] of {int};
	chan child_AnonymousTestEmptyReaderConcurrent1251220 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
		for(i : 0.. 5-1) {
		for10: skip;
		wg.update!2;
		run AnonymousTestEmptyReaderConcurrent125122(wg,child_AnonymousTestEmptyReaderConcurrent1251220);
		run receiver(child_AnonymousTestEmptyReaderConcurrent1251220);
		run AnonymousTestEmptyReaderConcurrent130122(wg,child_AnonymousTestEmptyReaderConcurrent1301221);
		run receiver(child_AnonymousTestEmptyReaderConcurrent1301221);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestEmptyReaderConcurrent125122(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousTestEmptyReaderConcurrent130122(Wgdef wg;chan child) {
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

