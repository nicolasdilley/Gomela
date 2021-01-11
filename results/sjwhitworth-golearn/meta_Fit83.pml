#define Fit_b_Models  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example742554634/meta/bagging.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wait;
	bool state = false;
	int i;
	int b_Models = Fit_b_Models;
	run wgMonitor(wait);
		for(i : 0.. b_Models-1) {
		for10: skip;
		wait.Add!1;
		run go_Anonymous0(wait);
		for10_end: skip
	};
	for10_exit: skip;
	wait.Wait?0
stop_process:skip
}

proctype go_Anonymous0(Wgdef wait) {
	bool closed; 
	int i;
	bool state;
	wait.Add!-1;
	stop_process: skip
}
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

