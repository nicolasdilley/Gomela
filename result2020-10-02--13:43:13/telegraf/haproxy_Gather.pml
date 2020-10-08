
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example070058214/plugins/inputs/haproxy/haproxy.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int g_Servers = 5;
	bool state = false;
	int endpoints = 5;
	Wgdef wg;
	int matches = 5;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. g_Servers) {
for10:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
						for(i : 1.. matches) {
for11:
			}
		:: true -> 
						for(i : 1.. matches) {
for11:
			}
		fi
	};
	run wgMonitor(wg);
	wg.Add!endpoints;
		for(i : 1.. endpoints) {
for20:		run Anonymous0(wg)
	};
	wg.Wait?0;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	wg.Add!-1;
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
