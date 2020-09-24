#define snapshotSet  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example207211691/internal/lsp/text_synchronization.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int snapshots = 5;
	int deletions = 5;
	int uris = 5;
	Wgdef diagnosticWG;
	int snapshotByURI = 5;
	int snapshotSet = 5;
	int releases = 5;
	bool state = false;
	run wgMonitor(diagnosticWG);
	
	if
	:: true -> 
		run Anonymous0(diagnosticWG)
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
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
		fi;
		do
		:: true -> 
for31:			
			if
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			:: true;
			fi
		:: true -> 
			break
		od
	:: true -> 
		break
	od;
	do
	:: true -> 
for40:		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi
	:: true -> 
		break
	od;
		for(i : 1.. snapshotSet) {
for50:		
		if
		:: true -> 
			do
			:: true -> 
for51:				
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
				fi
			:: true -> 
				break
			od
		:: true;
		fi;
		diagnosticWG.Add!1;
		run Anonymous1(diagnosticWG)
	};
	run Anonymous2(diagnosticWG);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef diagnosticWG) {
	bool closed; 
	int i;
	diagnosticWG.Wait?0;
stop_process:
}
proctype Anonymous1(Wgdef diagnosticWG) {
	bool closed; 
	int i;
	diagnosticWG.Add!-1;
stop_process:
}
proctype Anonymous2(Wgdef diagnosticWG) {
	bool closed; 
	int i;
	diagnosticWG.Wait?0;
	do
	:: true -> 
for60:
	:: true -> 
		break
	od;
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
