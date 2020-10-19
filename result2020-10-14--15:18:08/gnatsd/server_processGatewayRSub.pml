#define processGatewayRSub_e_ni  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example507681897/server/gateway.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int e_ni = processGatewayRSub_e_ni;
	bool state = false;
	int i;
	

	if
	:: true;
	:: true;
	:: true -> 
		goto stop_process
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
						for(i : 1.. e_ni) {
for10:
			}
		fi
	:: true -> 
		
		if
		:: true -> 
						for(i : 1.. e_ni) {
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
	od;
stop_process:
}
