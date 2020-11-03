
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example152026049/internal/goofys.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef fh_mpuWG;
	int i;
	Wgdef _mpuWG;
	bool state = false;
	run wgMonitor(fh_mpuWG);
	run wgMonitor(_mpuWG);
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
