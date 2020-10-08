
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example560560933/cli/service.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int startFuncs = 5;
	Wgdef wg;
	int i;
	
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
			fi;
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	run wgMonitor(wg);
		for(i : 1.. startFuncs) {
for10:		
		if
		:: true -> 
			break
		:: true;
		fi;
		wg.Add!1;
		run Anonymous0(errs,wg)
	};
	wg.Wait?0;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef errs;Wgdef wg) {
	bool closed; 
	int i;
	do
	:: errs.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: errs.async_rcv?0;
			:: errs.sync?0;
			fi
		fi
	od;
	wg.Add!-1;
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
