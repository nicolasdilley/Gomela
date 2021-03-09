#define SemaphoreConcurrency_int64127511  3

// https://github.com/gravitational/teleport/blob/7b21cbaa566b561b40f322245b9ef5b931cbedfb/lib/services/suite/suite.go#L1255
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	int int64127511 = SemaphoreConcurrency_int64127511;
	run wgMonitor(wg);
		for(i : int64127511.. 200-1) {
		for10: skip;
		wg.Add!1;
		run go_Anonymous0(wg);
		for10_end: skip
	};
	for10_exit: skip;
	wg.Wait?0
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

