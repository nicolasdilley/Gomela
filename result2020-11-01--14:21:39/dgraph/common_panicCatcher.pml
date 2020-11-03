#define panicCatcher_tests 3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example411586957/graphql/e2e/common/error.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef ts_wg;
	int i;
	int tests = panicCatcher_tests;
	bool state = false;
	run wgMonitor(ts_wg);
		for(i : 0.. tests-1) {
for10:
	}
stop_process:}

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

