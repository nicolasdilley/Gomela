
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example476275474/go/vt/vtgate/engine/concatenate.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef fieldset;
	int i;
	Wgdef g_wg;
	bool state = false;
	run wgMonitor(fieldset);
	run wgMonitor(g_wg);
	fieldset.Add!1;
	
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
