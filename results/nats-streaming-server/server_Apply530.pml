
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example228396225/server/clustering.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef s_wg;
	int i;
	Wgdef s_ioChannelWG;
	bool state = false;
	run wgMonitor(s_wg);
	run wgMonitor(s_ioChannelWG)
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
