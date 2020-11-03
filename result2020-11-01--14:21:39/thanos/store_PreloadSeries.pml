#define PreloadSeries_fromCache 3
#define PreloadSeries_parts 1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example011830901/pkg/store/bucket.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int parts = PreloadSeries_parts;
	Wgdef g_wg;
	bool state = false;
	int fromCache = PreloadSeries_fromCache;
	int i;
		for(i : 0.. fromCache-1) {
for10:
	};
	run wgMonitor(g_wg);
		for(i : 0.. parts-1) {
for20:
	};
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

