
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example309787322/core/dnsserver/server.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef s_dnsWg;
	int i;
	int site_Plugin = 5;
	bool state = false;
	run wgMonitor(s_dnsWg);
	s_dnsWg.Add!1;
		for(i : 1.. group) {
for10:		
		if
		:: 0 != -1 && site_Plugin - 1 != -1 -> 
						for(i : 0.. site_Plugin - 1) {
for11:
			}
		:: else -> 
			do
			:: true -> 
for11:
			:: true -> 
				break
			od
		fi;
for11_exit:
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
