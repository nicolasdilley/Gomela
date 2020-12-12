
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example375738237/server/gateway.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int e_ni = -2;
	bool state = false;
	int i;
	
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
		fi
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		Wgdef srv_grWG;
		run wgMonitor(srv_grWG)
	:: true -> 
		
		if
		:: true -> 
						for(i : 0.. e_ni-1) {
for10:
			}
		fi
	:: true -> 
		
		if
		:: true -> 
						for(i : 0.. e_ni-1) {
for10:
			}
		fi
	fi;
	goto stop_process
stop_process:}

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
