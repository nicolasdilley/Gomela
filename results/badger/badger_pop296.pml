
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example946677975/iterator.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	Wgdef i_next_wg;
	Wgdef i_wg;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(i_wg);
	
	if
	:: true -> 
		Wgdef l_tail_wg;
		run wgMonitor(l_tail_wg);
		Wgdef l_head_wg;
		run wgMonitor(l_head_wg)
	fi;
	run wgMonitor(i_next_wg);
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
