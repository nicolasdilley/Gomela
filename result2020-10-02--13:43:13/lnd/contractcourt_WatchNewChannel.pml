
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example473489835/contractcourt/chain_arbitrator.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef chainWatcher_wg;
	int i;
	Wgdef channelArb_wg;
	Wgdef __wg;
	Wgdef _wg;
	Wgdef _wg;
	bool state = false;
	run wgMonitor(__wg);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(chainWatcher_wg);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(_wg);
	run wgMonitor(channelArb_wg);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(_wg);
	
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
