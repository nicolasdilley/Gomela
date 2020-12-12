
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example765710631/pipeline/protobuf.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	Wgdef p_pConfig_decodersWg;
	Wgdef p_pConfig_filtersWg;
	Wgdef p_pConfig_inputsWg;
	bool state = false;
	run wgMonitor(p_pConfig_filtersWg);
	run wgMonitor(p_pConfig_decodersWg);
	run wgMonitor(p_pConfig_inputsWg)
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
