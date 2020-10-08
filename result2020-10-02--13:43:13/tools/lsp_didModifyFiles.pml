
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example906103686/internal/lsp/text_synchronization.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef diagnosticWG;
	int snapshotSet = 5;
	int snapshotByURI = 5;
	int i;
	int deletions = 5;
	int snapshots = 5;
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
		for(i : 1.. deletions) {
for10:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	};
		for(i : 1.. modifications) {
for20:
	};
		for(i : 1.. snapshotByURI) {
for30:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 1.. snapshots) {
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
		}
	};
		for(i : 1.. modifications) {
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
	};
		for(i : 1.. snapshotSet) {
for50:		diagnosticWG.Add!1;
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
		for(i : 1.. releases) {
for60:
	};
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
