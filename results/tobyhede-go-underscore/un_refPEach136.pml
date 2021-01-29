#define refPEach_slice  0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example689665236/each.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef done;
	int num_msgs = 0;
	bool state = false;
	int i;
	int slice = refPEach_slice;
	run wgMonitor(done);
		for(i : 0.. slice-1) {
		for10: skip;
		done.Add!1;
		run go_Anonymous0(done);
		for10_end: skip
	};
	for10_exit: skip;
	done.Wait?0
stop_process:skip
}

proctype go_Anonymous0(Wgdef done) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	done.Add!-1;
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

