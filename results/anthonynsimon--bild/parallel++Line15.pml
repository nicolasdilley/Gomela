#define ub_for23_0  3

// https://github.com/anthonynsimon/bild/blob/153f9d751f27d1016e4131cc91346aea623a7db0/parallel/parallel.go#L15
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	

	if
	:: true -> 
		run wgMonitor(wg);
				for(i : 0.. ub_for23_0) {
			for10: skip;
			wg.Add!1;
			run go_Anonymous0(wg);
			for10_end: skip
		};
		for10_exit: skip;
		wg.Wait?0
	fi
stop_process:skip
}

proctype go_Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	wg.Add!-1
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

