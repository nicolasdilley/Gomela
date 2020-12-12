
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example228396225/server/server.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef nca_wg;
	Wgdef ncr_wg;
	Wgdef ns_grWG;
	Wgdef nc_wg;
	bool state = false;
	Wgdef ncs_wg;
	Wgdef ncsr_wg;
	Wgdef ftnc_wg;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(ns_grWG);
	run wgMonitor(ncs_wg);
	run wgMonitor(ncr_wg);
	run wgMonitor(ncsr_wg);
	run wgMonitor(nc_wg);
	run wgMonitor(ftnc_wg);
	run wgMonitor(nca_wg)
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
