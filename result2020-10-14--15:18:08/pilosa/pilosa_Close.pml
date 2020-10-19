#define close_v_fragments  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example953798272/view.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef eg_wg;
	int i;
	int v_fragments = close_v_fragments;
	bool state = false;
	run wgMonitor(eg_wg);
fragLoop:			for(i : 1.. v_fragments) {
for10:		do
		:: true -> 
			break
		od
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
