#define lb_for41_0  -1
#define ub_for41_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example070058214/plugins/inputs/socket_listener/socket_listener.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	int ssl_connections = 5;
	bool state = false;
	run wgMonitor(wg);
		for(i : lb_for41_0.. ub_for41_1) {
for10:		
		if
		:: true -> 
			break
		:: true;
		fi;
		wg.Add!1;
		run Anonymous0()
	};
for10_exit:		for(i : 1.. ssl_connections) {
for20:
	};
	wg.Wait?0
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
stop_process:
}
proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
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
