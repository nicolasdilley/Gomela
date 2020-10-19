#define DeleteUser_sys_peerClients  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example255495480/cmd/notification.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef ng_wg;
	int i;
	int sys_peerClients = DeleteUser_sys_peerClients;
	bool state = false;
	run wgMonitor(ng_wg);
		for(i : 1.. sys_peerClients) {
for10:
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
