#define setupExecAllocator_opts 3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example551191503/allocate.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef ep_wg;
	int i;
	int opts = setupExecAllocator_opts;
	bool state = false;
	run wgMonitor(ep_wg);
		for(i : 0.. opts-1) {
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

