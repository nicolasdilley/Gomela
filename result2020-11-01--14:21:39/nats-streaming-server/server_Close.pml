#define Close_n_conns 0
#define Close_conns 1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example040657727/server/raft_transport.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int n_conns = Close_n_conns;
	Wgdef nc_wg;
	int conns = Close_conns;
	bool state = false;
	run wgMonitor(nc_wg);
		for(i : 0.. n_conns-1) {
for10:
	};
		for(i : 0.. conns-1) {
for20:
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

