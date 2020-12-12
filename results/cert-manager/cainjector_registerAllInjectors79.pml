#define registerAllInjectors_controllers  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example520183714/pkg/controller/cainjector/setup.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef g_wg;
	int i;
	int controllers = registerAllInjectors_controllers;
	bool state = false;
	run wgMonitor(g_wg);
	
	if
	:: true -> 
				for(i : 0.. controllers-1) {
for20:			
			if
			:: true -> 
				break
			:: true;
			fi
		}
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
