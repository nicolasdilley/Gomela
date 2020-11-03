#define sync_targets 3
#define sync_sp_activeTargets 0
#define sync_sp_loops 3
#define sync_uniqueLoops 1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example614289777/scrape/scrape.go
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
		for(i : 0.. targets-1) {
for10:
	};
	run wgMonitor(wg);
		for(i : 0.. sp_activeTargets-1) {
for20:		
		if
		:: true -> 
			wg.Add!1;
			run Anonymous0(wg)
		:: true;
		fi
	};
		for(i : 0.. sp_loops-1) {
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
	od
}

