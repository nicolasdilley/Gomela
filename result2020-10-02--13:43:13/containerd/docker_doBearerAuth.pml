
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example130484253/remotes/docker/authorizer.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	Wgdef r_WaitGroup;
	Wgdef r_WaitGroup;
	Wgdef _WaitGroup;
	bool state = false;
	run wgMonitor(r_WaitGroup);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(r_WaitGroup);
	run wgMonitor(_WaitGroup);
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi;
					goto stop_process
				:: true;
				fi
			:: true;
			fi;
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
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