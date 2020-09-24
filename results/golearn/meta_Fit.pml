#define b_Models  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example981856083/meta/bagging.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wait;
	int i;
	int b_Models = 5;
	bool state = false;
	run wgMonitor(wait);
		for(i : 1.. b_Models) {
for10:		wait.Add!1;
		run Anonymous0(wait)
	};
	wait.Wait?0
stop_process:}

proctype Anonymous0(Wgdef wait) {
	bool closed; 
	int i;
	wait.Add!-1;
stop_process:
}
proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
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
	od;
stop_process:
}
