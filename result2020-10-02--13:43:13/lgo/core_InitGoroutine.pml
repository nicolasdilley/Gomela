
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example056791731/core/core.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	Wgdef e_routineWait;
	bool state = false;
	run wgMonitor(e_routineWait);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	e_routineWait.Add!1;
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
