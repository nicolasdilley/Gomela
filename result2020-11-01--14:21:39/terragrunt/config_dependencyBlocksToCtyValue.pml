#define dependencyBlocksToCtyValue_dependencyConfigs 3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example923076701/config/dependency.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef dependencyErrGroup_wg;
	int i;
	int dependencyConfigs = dependencyBlocksToCtyValue_dependencyConfigs;
	bool state = false;
	run wgMonitor(dependencyErrGroup_wg);
		for(i : 0.. dependencyConfigs-1) {
for10:
	};
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

