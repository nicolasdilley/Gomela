#define Fit_b_Models  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example654572786/meta/bagging.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wait;
	int i;
	int b_Models = Fit_b_Models;
	bool state = false;
	run wgMonitor(wait);
		for(i : 0.. b_Models-1) {
for10:		wait.Add!1;
		run Anonymous0(wait)
	};
	wait.Wait?0
stop_process:}

proctype Anonymous0(Wgdef wait) {
	bool closed; 
	int i;
	bool state;
	wait.Add!-1;
stop_process:
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
end:		
		if
		:: wg.Add?i -> 
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
		fi
	od
}
