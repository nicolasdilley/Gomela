
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example168625059/remotes/docker/authorizer.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef _WaitGroup;
	Wgdef r_WaitGroup;
	bool state = false;
	int i;
	run wgMonitor(r_WaitGroup);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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
stop_process:skip
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
end: if
		:: wg.Add?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
	fi
od
}

