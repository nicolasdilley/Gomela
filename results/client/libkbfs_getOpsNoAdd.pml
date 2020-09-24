
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example131909709/go/kbfs/libkbfs/kbfs_ops.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef ops_doneWg;
	int i;
	Wgdef ops_doneWg;
	bool state = false;
	run wgMonitor(ops_doneWg);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(ops_doneWg);
	
	if
	:: true -> 
		Wgdef ops_doneWg;
		run wgMonitor(ops_doneWg);
		Wgdef _doneWg;
		run wgMonitor(_doneWg)
	:: true;
	fi;
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
