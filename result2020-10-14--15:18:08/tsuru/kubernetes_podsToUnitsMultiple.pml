#define podsToUnitsMultiple_baseApps  60
#define podsToUnitsMultiple_baseNodes  60
#define podsToUnitsMultiple_pods  60
#define podsToUnitsMultiple_ports  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example490499155/provision/kubernetes/provisioner.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef controller_wg;
	int ports = podsToUnitsMultiple_ports;
	int baseNodes = podsToUnitsMultiple_baseNodes;
	bool state = false;
	int baseApps = podsToUnitsMultiple_baseApps;
	int pods = podsToUnitsMultiple_pods;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. baseApps) {
for10:
	};
	run wgMonitor(controller_wg);
	
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
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
		for(i : 1.. baseNodes) {
for20:
	};
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. pods) {
for30:		
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
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			:: true;
			fi;
			
			if
			:: true -> 
								for(i : 1.. ports) {
for31:
				}
			:: true;
			fi
		:: true;
		fi
	};
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
