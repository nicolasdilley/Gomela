
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example906103686/go/packages/golist.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int containFiles = 5;
	int query = 5;
	int restPatterns = 5;
	Wgdef sizeswg;
	int containsCandidates = 5;
	int pkg_GoFiles = 5;
	int modifiedPkgs = 5;
	bool state = false;
	run wgMonitor(sizeswg);
	
	if
	:: true -> 
		sizeswg.Add!1;
		run Anonymous0(sizeswg)
	:: true;
	fi;
extractQueries:			for(i : 1.. patterns) {
for10:		
		if
		:: true -> 
			

			if
			:: true;
			:: true;
			:: true;
			:: true -> 
								for(i : 1.. query) {
for11:
				};
				goto stop_process
			fi
		:: true -> 
			

			if
			:: true;
			:: true;
			:: true;
			:: true -> 
								for(i : 1.. query) {
for11:
				};
				goto stop_process
			fi
		fi
	};
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	
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
	
	if
	:: true -> 
				for(i : 1.. containsCandidates) {
for20:						for(i : 1.. containFiles) {
for21:								for(i : 1.. pkg_GoFiles) {
for22:
				}
			}
		}
	:: true;
	fi;
		for(i : 1.. restPatterns) {
for30:				for(i : 1.. modifiedPkgs) {
for31:
		}
	};
	sizeswg.Wait?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef sizeswg) {
	bool closed; 
	int i;
	sizeswg.Add!-1;
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
