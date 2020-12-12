
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example765710631/pipeline/plugin_runners.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	Wgdef pConfig_decodersWg;
	Wgdef pConfig_filtersWg;
	Wgdef pConfig_inputsWg;
	bool state = false;
	run wgMonitor(pConfig_filtersWg);
	run wgMonitor(pConfig_decodersWg);
	run wgMonitor(pConfig_inputsWg)
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
