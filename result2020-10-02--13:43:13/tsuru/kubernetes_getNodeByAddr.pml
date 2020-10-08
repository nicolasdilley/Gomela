
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example978759886/provision/kubernetes/helpers.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int n_Status_Addresses = 5;
	Wgdef controller_wg;
	bool state = false;
	int nodeList = 5;
	int i;
	
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
		goto stop_process
	:: true;
	fi;
nodesloop:			for(i : 1.. nodeList) {
for10:				for(i : 1.. n_Status_Addresses) {
for11:			
			if
			:: true -> 
				goto nodesloop
			:: true;
			fi
		}
	};
	
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
