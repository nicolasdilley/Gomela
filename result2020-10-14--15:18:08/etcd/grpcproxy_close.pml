#define close_wps_watchers  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example136822689/proxy/grpcproxy/watch.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	int wps_watchers = close_wps_watchers;
	bool state = false;
	run wgMonitor(wg);
	wg.Add!wps_watchers;
		for(i : 1.. wps_watchers) {
for10:		run Anonymous0(wg)
	};
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
