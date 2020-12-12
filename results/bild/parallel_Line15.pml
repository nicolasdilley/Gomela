#define lb_for23_0  -1
#define ub_for23_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example763683636/parallel/parallel.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		Wgdef wg;
		run wgMonitor(wg);
				for(i : lb_for23_0.. ub_for23_1) {
for10:			wg.Add!1;
			run Anonymous0(wg)
		};
for10_exit:		wg.Wait?0
	:: true -> 
		Wgdef wg;
		run wgMonitor(wg);
				for(i : lb_for23_0.. ub_for23_1) {
for10:			wg.Add!1;
			run Anonymous0(wg)
		};
for10_exit:		wg.Wait?0
	fi
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
stop_process:	wg.Add!-1
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
