
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example933794056/les/test_helper.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	Wgdef server_wg;
	Wgdef dist_wg;
	Wgdef client_wg;
	bool state = false;
	run wgMonitor(dist_wg);
	run wgMonitor(server_wg);
	run wgMonitor(client_wg);
	
	if
	:: true -> 
		do
		:: true;
		od
	:: true;
	fi;
	goto stop_process
stop_process:}

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