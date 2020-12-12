#define getRoutes_drivers  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example802418050/examples/hotrod/services/frontend/best_eta.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	int drivers = getRoutes_drivers;
	bool state = false;
	run wgMonitor(wg);
		for(i : 0.. drivers-1) {
for10:		wg.Add!1
	};
	wg.Wait?0;
	goto stop_process
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
