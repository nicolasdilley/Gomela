
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example355453106/builder/builder.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef srv_serveWG;
	int i;
	Wgdef bs_srv_serveWG;
	bool state = false;
	run wgMonitor(srv_serveWG);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(bs_srv_serveWG);
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
