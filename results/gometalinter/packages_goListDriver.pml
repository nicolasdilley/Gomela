
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example522730266/_linters/src/golang.org/x/tools/go/packages/golist.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int query = 5;
	int i;
	int containFiles = 5;
	Wgdef sizeswg;
	int containsCandidates = 5;
	int pkg_GoFiles = 5;
	bool state = false;
	run wgMonitor(sizeswg);
	
	if
	:: true -> 
		sizeswg.Add!1;
		run Anonymous0(sizeswg)
	:: true;
	fi;
extractQueries:		do
	:: true -> 
for10:		
		if
		:: true -> 
			

			if
			:: true;
			:: true;
			:: true;
			:: true;
			:: true -> 
				do
				:: true -> 
for11:
				:: true -> 
					break
				od;
				goto stop_process
			fi
		:: true -> 
			

			if
			:: true;
			:: true;
			:: true;
			:: true;
			:: true -> 
				do
				:: true -> 
for11:
				:: true -> 
					break
				od;
				goto stop_process
			fi
		fi
	:: true -> 
		break
	od;
	
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
		do
		:: true -> 
for20:			do
			:: true -> 
for21:				do
				:: true -> 
for22:
				:: true -> 
					break
				od
			:: true -> 
				break
			od
		:: true -> 
			break
		od
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
