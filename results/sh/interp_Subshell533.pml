
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example999095338/interp/api.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef r2_wgProcSubsts;
	int i;
	int r_alias = -2;
	bool state = false;
	run wgMonitor(r2_wgProcSubsts);
	
	if
	:: true -> 
				for(i : 0.. r_alias-1) {
for50:
		}
	:: true;
	fi;
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
	od
}
