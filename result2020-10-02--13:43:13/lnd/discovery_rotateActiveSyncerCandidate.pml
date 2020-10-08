
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example473489835/discovery/sync_manager.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef activeSyncer_wg;
	int i;
	Wgdef candidate_wg;
	bool state = false;
	run wgMonitor(activeSyncer_wg);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(candidate_wg);
	
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
		goto stop_process
	:: true;
	fi
stop_process:}

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
