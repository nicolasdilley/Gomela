#define Subshell_r_Vars  60
#define Subshell_v_Map  60
#define Subshell_r_funcVars  60
#define Subshell_r_cmdVars  60
#define Subshell_r_Funcs  60
#define Subshell_r_alias  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example702681990/interp/api.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int r_funcVars = Subshell_r_funcVars;
	int r_Vars = Subshell_r_Vars;
	int r_Funcs = Subshell_r_Funcs;
	Wgdef r2_wgProcSubsts;
	int v_Map = Subshell_v_Map;
	int r_cmdVars = Subshell_r_cmdVars;
	int r_alias = Subshell_r_alias;
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
