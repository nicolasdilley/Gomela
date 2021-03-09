#define readBlobsP_rs  3

// https://github.com/attic-labs/noms/blob/26620a34bc8c95812037588869d4790b5581b34d/go/types/blob.go#L215
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	int rs = readBlobsP_rs;
	

	if
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	fi;
	run wgMonitor(wg);
	wg.Add!rs;
		for(i : 0.. rs-1) {
		for10: skip;
		run go_Anonymous0(wg);
		for10_end: skip
	};
	for10_exit: skip;
	wg.Wait?0;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.Add!-1;
	stop_process: skip
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

