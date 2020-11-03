#define Gather_g_Servers 3
#define Gather_matches 0
#define Gather_endpoints 3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example729075595/plugins/inputs/haproxy/haproxy.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int g_Servers = Gather_g_Servers;
	bool state = false;
	int endpoints = Gather_endpoints;
	Wgdef wg;
	int matches = Gather_matches;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 0.. g_Servers-1) {
for10:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
						for(i : 0.. matches-1) {
for11:
			}
		:: true -> 
						for(i : 0.. matches-1) {
for11:
			}
		fi
	};
	run wgMonitor(wg);
	wg.Add!endpoints;
		for(i : 0.. endpoints-1) {
for20:		run Anonymous0(wg)
	};
	wg.Wait?0;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
stop_process:	wg.Add!-1
}
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
	od
}

