#define forAllUids_ts_targets  ??
#define forAllUids_target_sources  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example476275474/go/vt/wrangler/traffic_switcher.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int ts_targets = forAllUids_ts_targets;
	Wgdef wg;
	int target_sources = forAllUids_target_sources;
	bool state = false;
	run wgMonitor(wg);
		for(i : 0.. ts_targets-1) {
for10:				for(i : 0.. target_sources-1) {
for11:			wg.Add!1;
			run Anonymous0(wg)
		}
	};
	wg.Wait?0;
	goto stop_process
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
