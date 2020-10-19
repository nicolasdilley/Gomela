#define NewHost_importers  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example950889170/pkg/importer/importer.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef h_didInit;
	int i;
	int importers = NewHost_importers;
	bool state = false;
	run wgMonitor(h_didInit);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. importers) {
for10:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	};
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
	od;
stop_process:
}
