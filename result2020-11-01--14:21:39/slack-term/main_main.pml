
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example345258278/main.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef customEvtStream_wg;
	int i;
	Wgdef termui_DefaultEvtStream_wg;
	bool state = false;
	run wgMonitor(customEvtStream_wg);
	run wgMonitor(termui_DefaultEvtStream_wg)
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
