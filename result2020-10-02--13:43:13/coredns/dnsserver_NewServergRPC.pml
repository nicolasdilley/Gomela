
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example309787322/core/dnsserver/server_grpc.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef s_dnsWg;
	int i;
	int s_zones = 5;
	bool state = false;
	run wgMonitor(s_dnsWg);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. s_zones) {
for10:
	};
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