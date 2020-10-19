
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example798243311/nats/server.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef s_Server_wg;
	Wgdef server_wg;
	int i;
	Wgdef server_ioChannelWG;
	Wgdef s_Server_ioChannelWG;
	bool state = false;
	run wgMonitor(server_wg);
	run wgMonitor(server_ioChannelWG);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(s_Server_wg);
	run wgMonitor(s_Server_ioChannelWG);
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
