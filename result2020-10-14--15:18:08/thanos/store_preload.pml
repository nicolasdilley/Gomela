#define preload_r_preloads  60
#define preload_parts  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example526373364/pkg/store/bucket.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int r_preloads = preload_r_preloads;
	Wgdef g_wg;
	int parts = preload_parts;
	bool state = false;
	run wgMonitor(g_wg);
		for(i : 1.. r_preloads) {
for10:				for(i : 1.. parts) {
for11:
		}
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
	od;
stop_process:
}
