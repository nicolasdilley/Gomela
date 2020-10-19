#define startMockServers_addrs  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example134145316/client/mock/mockserver/mockserver.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef ms_wg;
	int i;
	int addrs = startMockServers_addrs;
	bool state = false;
	run wgMonitor(ms_wg);
		for(i : 1.. addrs) {
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
	od;
stop_process:
}
