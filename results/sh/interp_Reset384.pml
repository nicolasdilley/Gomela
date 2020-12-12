
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example999095338/interp/api.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int r_Vars = -2;
	Wgdef _wgProcSubsts;
	int r_cmdVars = -2;
	bool state = false;
	run wgMonitor(_wgProcSubsts);
	
	if
	:: true -> 
				for(i : 0.. r_Vars-1) {
for10:
		}
	:: true -> 
				for(i : 0.. r_Vars-1) {
for10:
		}
	fi;
	
	if
	:: true -> 
				for(i : 0.. r_cmdVars-1) {
for20:
		}
	:: true -> 
				for(i : 0.. r_cmdVars-1) {
for20:
		}
	fi
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
