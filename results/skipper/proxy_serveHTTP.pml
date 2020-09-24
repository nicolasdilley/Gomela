
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example765760214/proxy/upgrade.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	chan child_proxycopyAsync1 = [0] of {int};
	Wgdef wg;
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
	
	if
	:: true -> 
		
		if
		:: true -> 
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
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
	wg.Add!2;
	
	if
	:: true -> 
		chan child_proxycopyAsync0 = [0] of {int};
		run proxycopyAsync(wg,child_proxycopyAsync0);
		child_proxycopyAsync0?0
	:: true -> 
		chan child_proxycopyAsync0 = [0] of {int};
		run proxycopyAsync(wg,child_proxycopyAsync0);
		child_proxycopyAsync0?0
	fi;
	run proxycopyAsync(child_proxycopyAsync1);
	child_proxycopyAsync1?0;
	wg.Wait?0;
	
	if
	:: true -> 
		do
		:: true;
		:: true -> 
			break
		od
	:: true;
	fi
stop_process:}

proctype proxycopyAsync(Wgdef wg;chan child) {
	bool closed; 
	int i;
	run Anonymous1();
	child!0;
stop_process:
}
proctype Anonymous1() {
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
