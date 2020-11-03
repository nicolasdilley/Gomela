#define registerAllInjectors_injectorSetups 0
#define registerAllInjectors_controllers 0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example718306823/pkg/controller/cainjector/setup.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int controllers = registerAllInjectors_controllers;
	Wgdef g_wg;
	bool state = false;
	int injectorSetups = registerAllInjectors_injectorSetups;
	int i;
		for(i : 0.. injectorSetups-1) {
for10:		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi
	};
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

