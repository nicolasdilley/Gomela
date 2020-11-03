#define Subshell_r_Vars  ??
#define Subshell_v_Map  ??
#define Subshell_r_funcVars  ??
#define Subshell_r_cmdVars  ??
#define Subshell_r_Funcs  ??
#define Subshell_r_alias  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example196228527/interp/api.go
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
		for(i : 0.. r_Vars-1) {
for10:		
		if
		:: true -> 
						for(i : 0.. v_Map-1) {
for11:
			}
		:: true;
		fi
	};
		for(i : 0.. r_funcVars-1) {
for20:
	};
		for(i : 0.. r_cmdVars-1) {
for30:
	};
		for(i : 0.. r_Funcs-1) {
for40:
	};
	
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
