
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example970072738/provisioner/inspec/provisioner.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	bool state = false;
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
	run wgMonitor(wg);
	wg.Add!2;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	wg.Wait?0;
	
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
