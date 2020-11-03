#define goListDriver_patterns  ??
#define goListDriver_query  ??
#define goListDriver_containsCandidates  ??
#define goListDriver_containFiles  ??
#define goListDriver_pkg_GoFiles  ??
#define goListDriver_restPatterns  ??
#define goListDriver_modifiedPkgs  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example131702815/go/packages/golist.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int restPatterns = goListDriver_restPatterns;
	int query = goListDriver_query;
	Wgdef sizeswg;
	int containFiles = goListDriver_containFiles;
	int i;
	int patterns = goListDriver_patterns;
	int containsCandidates = goListDriver_containsCandidates;
	int pkg_GoFiles = goListDriver_pkg_GoFiles;
	int modifiedPkgs = goListDriver_modifiedPkgs;
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
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
						for(i : 0.. containsCandidates-1) {
for20:								for(i : 0.. containFiles-1) {
for21:										for(i : 0.. pkg_GoFiles-1) {
for22:
					}
				}
			}
		:: true;
		fi;
				for(i : 0.. restPatterns-1) {
for30:						for(i : 0.. modifiedPkgs-1) {
for31:
			}
		}
	:: true;
	fi;
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
