
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example615810027/builtin/provisioners/puppet/resource_provisioner.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int p_CustomAttributes = 5;
	Wgdef p_outputWG;
	int p_ExtensionRequests = 5;
	bool state = false;
	run wgMonitor(p_outputWG);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		

		if
		:: true;
		:: true;
		:: true -> 
			goto stop_process
		fi
	:: true;
	fi;
	

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
		goto stop_process
	:: true;
	fi;
		for(i : 1.. p_CustomAttributes) {
for10:
	};
		for(i : 1.. p_ExtensionRequests) {
for20:
	};
	
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
