
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example730998850/command/build.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int artifacts_m = 5;
	int builds = 5;
	int files = 5;
	Wgdef wg;
	int errors_m = 5;
	int buildArtifacts = 5;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. builds) {
for10:
	};
	run wgMonitor(wg);
		for(i : 1.. builds) {
for20:		
		if
		:: true -> 
			break
		:: true;
		fi;
		
		if
		:: true -> 
			break
		:: true;
		fi;
		wg.Add!1;
		run Anonymous0(wg);
		
		if
		:: true -> 
			wg.Wait?0
		:: true;
		fi;
		
		if
		:: true -> 
			wg.Wait?0
		:: true;
		fi
	};
	wg.Wait?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
				for(i : 1.. errors_m) {
for30:
		}
	:: true;
	fi;
	
	if
	:: true -> 
				for(i : 1.. artifacts_m) {
for40:						for(i : 1.. buildArtifacts) {
for41:				
				if
				:: true -> 
										for(i : 1.. files) {
for42:
					}
				fi
			}
		}
	fi;
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
