#define refine_initial  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example109322714/go/packages/packages.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int lpkg_Imports = -2;
	int initial = refine_initial;
	bool state = false;
	int srcPkgs = -2;
	int i;
	
	if
	:: true -> 
				for(i : 0.. initial-1) {
for40:
		}
	:: true -> 
				for(i : 0.. initial-1) {
for50:
		}
	:: true -> 
				for(i : 0.. initial-1) {
for50:
		}
	fi;
	
	if
	:: true -> 
				for(i : 0.. srcPkgs-1) {
for60:						for(i : 0.. lpkg_Imports-1) {
for61:
			}
		}
	:: true;
	fi;
	
	if
	:: true -> 
		Wgdef wg;
		run wgMonitor(wg);
				for(i : 0.. initial-1) {
for70:			wg.Add!1;
			run Anonymous0(wg)
		};
		wg.Wait?0
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	wg.Add!-1;
stop_process:
}
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
