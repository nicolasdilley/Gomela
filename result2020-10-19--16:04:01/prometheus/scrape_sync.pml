#define sync_targets  5
#define sync_sp_activeTargets  5
#define sync_sp_loops  5
#define sync_uniqueLoops  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example445689738/scrape/scrape.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int uniqueLoops = sync_uniqueLoops;
	int sp_activeTargets = sync_sp_activeTargets;
	bool state = false;
	int targets = sync_targets;
	int sp_loops = sync_sp_loops;
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
	do
	:: true -> 
for40:
	:: true -> 
		break
	od;
	wg.Wait?0
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	wg.Add!-1;
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
	od;
stop_process:
}
