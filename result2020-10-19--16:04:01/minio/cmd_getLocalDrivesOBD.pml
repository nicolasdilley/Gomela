#define getLocalDrivesOBD_endpointServerSets  5
#define getLocalDrivesOBD_ep_Endpoints  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example255495480/cmd/obdinfo.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int endpointServerSets = getLocalDrivesOBD_endpointServerSets;
	Wgdef wg;
	int ep_Endpoints = getLocalDrivesOBD_ep_Endpoints;
	bool state = false;
	run wgMonitor(wg);
		for(i : 1.. endpointServerSets) {
for10:				for(i : 1.. ep_Endpoints) {
for11:			
			if
			:: true -> 
				wg.Add!1
			:: true;
			fi
		}
	};
	wg.Wait?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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
