#define restoreClientsFromSnapshot_serverSnap_Clients 3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example040657727/server/snapshot.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	Wgdef s_ioChannelWG;
	Wgdef s_wg;
	int serverSnap_Clients = restoreClientsFromSnapshot_serverSnap_Clients;
	bool state = false;
	run wgMonitor(s_wg);
	run wgMonitor(s_ioChannelWG);
		for(i : 0.. serverSnap_Clients-1) {
for10:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	};
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

