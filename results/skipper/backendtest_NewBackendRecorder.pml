
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example765760214/proxy/backendtest/backendrecorder.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef server_wg;
	int i;
	Wgdef handler_server_wg;
	bool state = false;
	run wgMonitor(server_wg);
	run wgMonitor(handler_server_wg);
	goto stop_process
stop_process:}

proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
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
	od;
stop_process:
}
