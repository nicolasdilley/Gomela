#define NewServer_group  60
#define NewServer_site_Plugin  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example035914154/core/dnsserver/server.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int group = NewServer_group;
	Wgdef s_dnsWg;
	int site_Plugin = NewServer_site_Plugin;
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
