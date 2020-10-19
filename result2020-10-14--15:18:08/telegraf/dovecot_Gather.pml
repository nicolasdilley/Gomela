#define Gather_d_Servers  60
#define Gather_d_Filters  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example985353586/plugins/inputs/dovecot/dovecot.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int d_Filters = Gather_d_Filters;
	Wgdef wg;
	bool state = false;
	int d_Servers = Gather_d_Servers;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
		for(i : 1.. d_Servers) {
for10:				for(i : 1.. d_Filters) {
for11:			wg.Add!1;
			run Anonymous0(wg)
		}
	};
	wg.Wait?0;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	wg.Add!-1;
stop_process:
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
	od;
stop_process:
}
