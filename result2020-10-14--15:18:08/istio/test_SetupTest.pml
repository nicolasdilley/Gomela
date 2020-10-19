
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example119114767/security/pkg/stsservice/test/setup.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef xds_serveWG;
	int i;
	Wgdef env_xdsServer_serveWG;
	bool state = false;
	run wgMonitor(xds_serveWG);
	run wgMonitor(env_xdsServer_serveWG);
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
