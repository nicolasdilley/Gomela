#define TestConcurrentFileStreams_numStreams 3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example541387238/registry/storage/driver/testsuites/testsuites.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	int numStreams = TestConcurrentFileStreams_numStreams;
	bool state = false;
	run wgMonitor(wg);
	wg.Add!numStreams;
		for(i : 0.. numStreams-1) {
for10:
	};
for10_exit:	wg.Wait?0
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

