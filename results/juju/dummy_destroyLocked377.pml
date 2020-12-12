
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example787825356/provider/dummy/environs.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef leaseManager_wg;
	bool state = false;
	Wgdef state_leaseManager_wg;
	Wgdef apiServer_wg;
	Wgdef state_apiServer_wg;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(apiServer_wg);
	run wgMonitor(leaseManager_wg);
	run wgMonitor(state_apiServer_wg);
	run wgMonitor(state_leaseManager_wg)
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
