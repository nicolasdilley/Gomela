#define initial  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example207211691/go/packages/packages.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int stubs = 5;
	int ld_pkgs = 5;
	int srcPkgs = 5;
	bool state = false;
	int initial = 5;
	int lpkg_Imports = 5;
	int i;
	do
	:: true -> 
for10:
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
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		break
	od;
	
	if
	:: true -> 
		do
		:: true -> 
for40:
		:: true -> 
			break
		od
	:: true -> 
		do
		:: true -> 
for50:
		:: true -> 
			break
		od
	:: true -> 
		do
		:: true -> 
for50:
		:: true -> 
			break
		od
	fi;
	
	if
	:: true -> 
		do
		:: true -> 
for60:			do
			:: true -> 
for61:
			:: true -> 
				break
			od
		:: true -> 
			break
		od
	:: true;
	fi;
	
	if
	:: true -> 
		Wgdef wg;
		run wgMonitor(wg);
				for(i : 1.. initial) {
for70:			wg.Add!1;
			run Anonymous0(wg)
		};
		wg.Wait?0
	:: true;
	fi;
	do
	:: true -> 
for80:
	:: true -> 
		break
	od;
	do
	:: true -> 
for90:
	:: true -> 
		break
	od;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	wg.Add!-1;
stop_process:
}
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
