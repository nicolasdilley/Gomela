#define RunContext_builds  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example970072738/command/build.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int artifacts_m = -2;
	int builds = RunContext_builds;
	int files = -2;
	Wgdef wg;
	int errors_m = -2;
	int buildArtifacts = -2;
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
	run wgMonitor(wg);
		for(i : 0.. builds-1) {
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
				for(i : 0.. errors_m-1) {
for30:
		}
	:: true;
	fi;
	
	if
	:: true -> 
				for(i : 0.. artifacts_m-1) {
for40:						for(i : 0.. buildArtifacts-1) {
for41:				
				if
				:: true -> 
										for(i : 0.. files-1) {
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
stop_process:	wg.Add!-1
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
