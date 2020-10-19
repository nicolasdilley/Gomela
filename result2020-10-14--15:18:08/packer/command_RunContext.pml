#define RunContext_builds  60
#define RunContext_errors_m  60
#define RunContext_artifacts_m  60
#define RunContext_buildArtifacts  60
#define RunContext_files  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example576693886/command/build.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int artifacts_m = RunContext_artifacts_m;
	int builds = RunContext_builds;
	int files = RunContext_files;
	Wgdef wg;
	int errors_m = RunContext_errors_m;
	int buildArtifacts = RunContext_buildArtifacts;
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
	od;
stop_process:
}
