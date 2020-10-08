
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example116500132/x-pack/filebeat/input/azureeventhub/input.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef in_workerWg;
	bool state = false;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Anonymous0();
	run wgMonitor(in_workerWg);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	do
	:: true;
	:: true;
	od;
stop_process:
}
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
