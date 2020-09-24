
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example950528148/interp/api.go
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
	do
	:: true -> 
for10:		
		if
		:: true -> 
			do
			:: true -> 
for11:
			:: true -> 
				break
			od
		:: true;
		fi
	:: true -> 
		break
	od;
	do
	:: true -> 
for20:
	:: true -> 
		break
	od;
	do
	:: true -> 
for30:
	:: true -> 
		break
	od;
	do
	:: true -> 
for40:
	:: true -> 
		break
	od;
	
	if
	:: true -> 
		do
		:: true -> 
for50:
		:: true -> 
			break
		od
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
