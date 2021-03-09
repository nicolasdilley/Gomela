
// https://github.com/elves/elvish/blob/87519a9d9cdfba7037b1b139b255a09ae3f5c290/pkg/eval/builtin_fn_flow.go#L162
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef w;
	int num_msgs = 0;
	bool state = false;
	int i;
	run wgMonitor(w);
	w.Wait?0;
	goto stop_process
stop_process:skip
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

