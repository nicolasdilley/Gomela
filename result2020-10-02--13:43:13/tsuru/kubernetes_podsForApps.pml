
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example978759886/provision/kubernetes/provisioner.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int appSel = 5;
	bool state = false;
	int pods = 5;
	Wgdef controller_wg;
	int inSelectorMap = 5;
	int i;
		for(i : 1.. apps) {
for10:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 1.. appSel) {
for11:
		}
	};
		for(i : 1.. inSelectorMap) {
for20:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
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
		goto stop_process
	:: true;
	fi;
		for(i : 1.. pods) {
for30:
	};
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