#define run_h_streamPairs 3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example828676006/pkg/cri/streaming/portforward/websocket.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	int h_streamPairs = run_h_streamPairs;
	bool state = false;
	run wgMonitor(wg);
	wg.Add!h_streamPairs;
		for(i : 0.. h_streamPairs-1) {
for10:		run Anonymous0()
	};
	wg.Wait?0
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	bool state;
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

