
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example265812302/singleinflight.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	Wgdef c_wg;
	Wgdef c_wg;
	Wgdef _wg;
	bool state = false;
	run wgMonitor(c_wg);
	
	if
	:: true -> 
		c_wg.Wait?0;
		goto stop_process
	:: true;
	fi;
	run wgMonitor(c_wg);
	c_wg.Add!1;
	run wgMonitor(_wg);
	c_wg.Add!-1;
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
