
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example369565110/app/file.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	bool state = false;
	int i;
		for(i : 1.. opts) {
for10:
	};
	
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
	
	if
	:: true -> 
		wg.Add!1;
		run Anonymous0()
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	wg.Wait?0;
	
	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		fi
	:: true;
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
