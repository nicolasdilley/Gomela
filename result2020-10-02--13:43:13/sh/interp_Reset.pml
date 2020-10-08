
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example401015372/interp/api.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int r_Vars = 5;
	Wgdef _wgProcSubsts;
	int r_cmdVars = 5;
	bool state = false;
	run wgMonitor(_wgProcSubsts);
	
	if
	:: true -> 
				for(i : 1.. r_Vars) {
for10:
		}
	:: true -> 
				for(i : 1.. r_Vars) {
for10:
		}
	fi;
	
	if
	:: true -> 
				for(i : 1.. r_cmdVars) {
for20:
		}
	:: true -> 
				for(i : 1.. r_cmdVars) {
for20:
		}
	fi
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
