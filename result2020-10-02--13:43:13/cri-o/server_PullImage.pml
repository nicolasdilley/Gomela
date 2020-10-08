
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example555974158/server/image_pull.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	Wgdef pullOp_wg;
	Wgdef pullOp_wg;
	int i;
	
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
		fi
	:: true;
	fi;
	run wgMonitor(pullOp_wg);
	run wgMonitor(pullOp_wg);
	
	if
	:: true -> 
		Wgdef pullOp_wg;
		run wgMonitor(pullOp_wg);
		Wgdef _wg;
		run wgMonitor(_wg);
		pullOp_wg.Add!1
	:: true;
	fi;
	goto stop_process;
	
	if
	:: true -> 
		pullOp_wg.Add!-1
	:: true -> 
		pullOp_wg.Wait?0
	:: true -> 
		pullOp_wg.Wait?0
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
