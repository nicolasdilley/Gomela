#define prog_packages  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example207211691/go/ssa/builder.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	int prog_packages = 5;
	bool state = false;
	run wgMonitor(wg);
		for(i : 1.. prog_packages) {
for10:		
		if
		:: true -> 
			wg.Add!1;
			run Anonymous0(wg)
		:: true -> 
			wg.Add!1;
			run Anonymous0(wg)
		fi
	};
	wg.Wait?0
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
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
