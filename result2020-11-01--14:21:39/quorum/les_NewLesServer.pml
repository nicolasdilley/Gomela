#define NewLesServer_AdvertiseProtocolVersions 1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example127052982/les/server.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int AdvertiseProtocolVersions = NewLesServer_AdvertiseProtocolVersions;
	Wgdef srv_handler_wg;
	int i;
		for(i : 0.. AdvertiseProtocolVersions-1) {
for10:
	};
	run wgMonitor(srv_handler_wg);
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

