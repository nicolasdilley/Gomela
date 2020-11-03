#define Gather_ja_URLs 1
#define Gather_ja_clients 0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example729075595/plugins/inputs/jolokia2/jolokia_agent.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int ja_clients = Gather_ja_clients;
	Wgdef wg;
	bool state = false;
	int ja_URLs = Gather_ja_URLs;
	int i;
	
	if
	:: true -> 
				for(i : 0.. ja_URLs-1) {
for10:
		}
	:: true;
	fi;
	run wgMonitor(wg);
		for(i : 0.. ja_clients-1) {
for20:		wg.Add!1;
		run Anonymous0(wg)
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

