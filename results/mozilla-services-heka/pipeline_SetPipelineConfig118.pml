
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example976469541/pipeline/protobuf.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef p_pConfig_inputsWg;
	Wgdef p_pConfig_decodersWg;
	Wgdef p_pConfig_filtersWg;
	bool state = false;
	int i;
	run wgMonitor(p_pConfig_filtersWg);
	run wgMonitor(p_pConfig_decodersWg);
	run wgMonitor(p_pConfig_inputsWg)
stop_process:skip
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
end: if
		:: wg.Add?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
	fi
od
}

