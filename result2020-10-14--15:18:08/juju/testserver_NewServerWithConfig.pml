
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example131217544/apiserver/testserver/server.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef cfg_Mux_clients;
	Wgdef mux_clients;
	int i;
	Wgdef httpServer_wg;
	Wgdef srv_wg;
	bool state = false;
	run wgMonitor(mux_clients);
	run wgMonitor(httpServer_wg);
	run wgMonitor(cfg_Mux_clients);
	run wgMonitor(srv_wg);
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
	od;
stop_process:
}
