
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example123902793/_linters/src/golang.org/x/tools/go/packages/packages.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int initial = 5;
	bool state = false;
	int lpkg_Imports = 5;
	int stubs = 5;
	int srcPkgs = 5;
	int i;
		for(i : 1.. roots) {
for10:
	};
		for(i : 1.. list) {
for20:
	};
		for(i : 1.. roots) {
for30:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	};
	
	if
	:: true -> 
				for(i : 1.. initial) {
for40:
		}
	:: true -> 
				for(i : 1.. initial) {
for50:
		}
	:: true -> 
				for(i : 1.. initial) {
for50:
		}
	fi;
		for(i : 1.. srcPkgs) {
for60:				for(i : 1.. lpkg_Imports) {
for61:
		}
	};
	
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
		for(i : 1.. initial) {
for80:
	};
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
