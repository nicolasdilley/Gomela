#define NewMultiWait_num 3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example523385946/multierr/multiwait.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef mw_wg;
	int i;
	int num = NewMultiWait_num;
	bool state = false;
	run wgMonitor(mw_wg);
	mw_wg.Add!num;
	goto stop_process
stop_process:}

proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: wg.Add?i -> 
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 -> 
end:		
		if
		:: wg.Add?i -> 
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
		fi
	od
}

