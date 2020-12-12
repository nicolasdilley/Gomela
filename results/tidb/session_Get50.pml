
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example832435838/session/tidb.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int dm_domains = -2;
	Wgdef d_wg;
	bool state = false;
	Wgdef _wg;
	int i;
	
	if
	:: true -> 
				for(i : 0.. dm_domains-1) {
for10:			goto stop_process
		}
	:: true;
	fi;
	run wgMonitor(d_wg);
	
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
	run wgMonitor(_wg);
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
