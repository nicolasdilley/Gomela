
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example672862733/pkg/workload/histogram/histogram.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int registered = 5;
	Wgdef wg;
	int i;
	int w_mu_registered = 5;
	int names = 5;
	bool state = false;
	run wgMonitor(wg);
		for(i : 1.. w_mu_registered) {
for10:		wg.Add!1;
		run Anonymous0(wg)
	};
	wg.Wait?0;
		for(i : 1.. names) {
for20:
	}
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
		for(i : 1.. registered) {
for11:
	};
	wg.Add!-1;
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
