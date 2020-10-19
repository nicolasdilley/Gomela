#define didModifyFiles_deletions  60
#define didModifyFiles_modifications  60
#define didModifyFiles_views  60
#define didModifyFiles_viewURIs  60
#define didModifyFiles_releases  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example971953206/internal/lsp/text_synchronization.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef diagnosticWG;
	int viewURIs = didModifyFiles_viewURIs;
	int modifications = didModifyFiles_modifications;
	int i;
	int deletions = didModifyFiles_deletions;
	int views = didModifyFiles_views;
	int releases = didModifyFiles_releases;
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
		for(i : 1.. views) {
for30:
	};
		for(i : 1.. viewURIs) {
for40:		diagnosticWG.Add!1;
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
	bool state;
	diagnosticWG.Wait?0;
stop_process:
}
proctype Anonymous1(Wgdef diagnosticWG) {
	bool closed; 
	int i;
	bool state;
	diagnosticWG.Add!-1;
stop_process:
}
proctype Anonymous2(Wgdef diagnosticWG) {
	bool closed; 
	int i;
	bool state;
	diagnosticWG.Wait?0;
		for(i : 1.. releases) {
for50:
	};
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
