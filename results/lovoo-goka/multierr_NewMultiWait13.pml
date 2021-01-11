#define NewMultiWait_num  0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example930502695/multierr/multiwait.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef mw_wg;
	bool state = false;
	int i;
	int num = NewMultiWait_num;
	run wgMonitor(mw_wg);
	mw_wg.Add!num;
	goto stop_process
stop_process:skip
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

