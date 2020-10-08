
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example862180471/go/vt/wrangler/traffic_switcher.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int toTables = 5;
	Wgdef wg;
	int i;
	int rules = 5;
	int ts_tables = 5;
	bool state = false;
	run wgMonitor(wg);
	wg.Wait?0;
	
	if
	:: true -> 
				for(i : 1.. rules) {
for10:						for(i : 1.. toTables) {
for11:								for(i : 1.. ts_tables) {
for12:
				}
			}
		}
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
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
