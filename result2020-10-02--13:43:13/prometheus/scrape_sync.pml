
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example279528907/scrape/scrape.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int sp_activeTargets = 5;
	bool state = false;
	int uniqueLoops = 5;
	Wgdef wg;
	int sp_loops = 5;
	int i;
		for(i : 1.. targets) {
for10:
	};
	run wgMonitor(wg);
		for(i : 1.. sp_activeTargets) {
for20:		
		if
		:: true -> 
			wg.Add!1;
			run Anonymous0(wg)
		:: true;
		fi
	};
		for(i : 1.. sp_loops) {
for30:
	};
		for(i : 1.. uniqueLoops) {
for40:
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