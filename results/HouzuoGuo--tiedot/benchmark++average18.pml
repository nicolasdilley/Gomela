#define ub_for24_0  3

// https://github.com/HouzuoGuo/tiedot/blob/6fb216206052eb2ae4306cf5e75acfa88f60d481/benchmark/benchmark.go#L18
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wp;
	int num_msgs = 0;
	bool state = false;
	int i;
	run wgMonitor(wp);
		for(i : 0.. ub_for24_0) {
		for10: skip;
		wp.Add!1;
		run go_Anonymous0(wp);
		for10_end: skip
	};
	for10_exit: skip;
	wp.Wait?0
stop_process:skip
}

proctype go_Anonymous0(Wgdef wp) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	wp.Add!-1
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

