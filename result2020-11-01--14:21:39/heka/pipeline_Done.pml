#define Done_pConfig_allSplitters 1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example276353088/pipeline/splitter_runner.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef pConfig_inputsWg;
	Wgdef pConfig_filtersWg;
	int i;
	Wgdef pConfig_decodersWg;
	int pConfig_allSplitters = Done_pConfig_allSplitters;
	bool state = false;
	run wgMonitor(pConfig_filtersWg);
	run wgMonitor(pConfig_decodersWg);
	run wgMonitor(pConfig_inputsWg);
		for(i : 0.. pConfig_allSplitters-1) {
for10:		
		if
		:: true -> 
			break
		:: true;
		fi
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

