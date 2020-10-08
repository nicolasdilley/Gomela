
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example531761686/pkg/fission-cli/cmd/support/dump.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int ress = 5;
	Wgdef wg;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. ress) {
for10:		wg.Add!1;
		run Anonymous0()
	};
	wg.Wait?0;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
stop_process:
}
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
