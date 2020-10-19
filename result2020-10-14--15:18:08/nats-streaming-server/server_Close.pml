#define Close_n_conns  60
#define Close_conns  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example980510934/server/raft_transport.go
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
		for(i : 1.. n_conns) {
for10:
	};
		for(i : 1.. conns) {
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
	od;
stop_process:
}
