
// https://github.com/ethereum/go-ethereum/blob/master/rlp/encode_test.go#L413
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestEncodeToReaderReturnToPool4130 = [1] of {int};
	run TestEncodeToReaderReturnToPool413(child_TestEncodeToReaderReturnToPool4130)
stop_process:skip
}

proctype TestEncodeToReaderReturnToPool413(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestEncodeToReaderReturnToPool4184150 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
		for(i : 0.. 5-1) {
		for10: skip;
		wg.update!1;
		run AnonymousTestEncodeToReaderReturnToPool418415(wg,child_AnonymousTestEncodeToReaderReturnToPool4184150);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestEncodeToReaderReturnToPool418415(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

