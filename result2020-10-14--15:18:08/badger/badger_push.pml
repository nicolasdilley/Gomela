
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example386370723/iterator.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef i_next_wg;
	int i;
	Wgdef l_tail_next_wg;
	bool state = false;
	run wgMonitor(i_next_wg);
	
	if
	:: true -> 
		Wgdef l_head_wg;
		run wgMonitor(l_head_wg);
		Wgdef l_tail_wg;
		run wgMonitor(l_tail_wg);
		goto stop_process
	:: true;
	fi;
	run wgMonitor(l_tail_next_wg)
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
