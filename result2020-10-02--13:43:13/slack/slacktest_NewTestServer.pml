
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example684685528/slacktest/server.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	Wgdef s_server_wg;
	Wgdef httpserver_wg;
	int i;
		for(i : 1.. custom) {
for10:
	};
	run wgMonitor(httpserver_wg);
	run wgMonitor(s_server_wg);
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