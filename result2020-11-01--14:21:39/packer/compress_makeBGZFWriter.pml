
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example120421127/post-processor/compress/post-processor.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef bgzfWriter_qwg;
	int i;
	Wgdef bgzfWriter_wg;
	bool state = false;
	run wgMonitor(bgzfWriter_qwg);
	run wgMonitor(bgzfWriter_wg);
	
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
