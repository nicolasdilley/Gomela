#define goListDriver_patterns 0
#define goListDriver_query 1
#define goListDriver_containsCandidates 0
#define goListDriver_containFiles 1
#define goListDriver_pkg_GoFiles 1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example955999608/_linters/src/golang.org/x/tools/go/packages/golist.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef sizeswg;
	int containFiles = goListDriver_containFiles;
	int query = goListDriver_query;
	int i;
	int patterns = goListDriver_patterns;
	int containsCandidates = goListDriver_containsCandidates;
	int pkg_GoFiles = goListDriver_pkg_GoFiles;
	bool state = false;
	run wgMonitor(sizeswg);
	
	if
	:: true -> 
		sizeswg.Add!1;
		run Anonymous0(sizeswg)
	:: true;
	fi;
extractQueries:			for(i : 0.. patterns-1) {
for10:		
		if
		:: true -> 
			

			if
			:: true;
			:: true;
			:: true;
			:: true;
			:: true -> 
								for(i : 0.. query-1) {
for11:
				};
				goto stop_process
			fi
		:: true -> 
			

			if
			:: true;
			:: true;
			:: true;
			:: true;
			:: true -> 
								for(i : 0.. query-1) {
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
	fi;
	sizeswg.Wait?0;
	
	if
	:: true -> 
		goto stop_process
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
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: true -> 
				for(i : 0.. containsCandidates-1) {
for20:						for(i : 0.. containFiles-1) {
for21:								for(i : 0.. pkg_GoFiles-1) {
for22:
				}
			}
		}
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef sizeswg) {
	bool closed; 
	int i;
	bool state;
	sizeswg.Add!-1;
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

