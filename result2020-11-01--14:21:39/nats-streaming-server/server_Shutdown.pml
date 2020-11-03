#define Shutdown_channels 1
#define Shutdown_subs 1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example040657727/server/server.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef nc_wg;
	Wgdef ns_grWG;
	int subs = Shutdown_subs;
	Wgdef ncr_wg;
	Wgdef nca_wg;
	bool state = false;
	Wgdef ncs_wg;
	Wgdef ncsr_wg;
	Wgdef ftnc_wg;
	int channels = Shutdown_channels;
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
	run wgMonitor(nca_wg);
		for(i : 0.. channels-1) {
for10:				for(i : 0.. subs-1) {
for11:
		}
	}
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

