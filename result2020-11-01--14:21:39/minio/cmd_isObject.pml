#define isObject_storageDisks 3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example320658119/cmd/erasure-common.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef g_wg;
	int i;
	int storageDisks = isObject_storageDisks;
	bool state = false;
	run wgMonitor(g_wg);
		for(i : 0.. storageDisks-1) {
for10:
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

