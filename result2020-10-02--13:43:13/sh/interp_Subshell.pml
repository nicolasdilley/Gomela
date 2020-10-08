
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example401015372/interp/api.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int r_funcVars = 5;
	int r_Vars = 5;
	int r_Funcs = 5;
	Wgdef r2_wgProcSubsts;
	int v_Map = 5;
	int r_cmdVars = 5;
	int r_alias = 5;
	bool state = false;
	run wgMonitor(r2_wgProcSubsts);
		for(i : 1.. r_Vars) {
for10:		
		if
		:: true -> 
						for(i : 1.. v_Map) {
for11:
			}
		:: true;
		fi
	};
		for(i : 1.. r_funcVars) {
for20:
	};
		for(i : 1.. r_cmdVars) {
for30:
	};
		for(i : 1.. r_Funcs) {
for40:
	};
	
	if
	:: true -> 
				for(i : 1.. r_alias) {
for50:
		}
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
