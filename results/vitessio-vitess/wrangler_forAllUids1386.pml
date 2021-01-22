#define forAllUids_ts_targets  3
#define forAllUids_target_sources  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example983313288/go/vt/wrangler/traffic_switcher.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	int target_sources = forAllUids_target_sources;
	int ts_targets = forAllUids_ts_targets;
	run wgMonitor(wg);
		for(i : 0.. ts_targets-1) {
		for10: skip;
				for(i : 0.. target_sources-1) {
			for11: skip;
			wg.Add!1;
			run go_Anonymous0(wg);
			for11_end: skip
		};
		for11_exit: skip;
		for10_end: skip
	};
	for10_exit: skip;
	wg.Wait?0;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	wg.Add!-1
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
bool closed;
int i;
bool state;
do
	:: wg.Add?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.Add?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
	fi
od
}

