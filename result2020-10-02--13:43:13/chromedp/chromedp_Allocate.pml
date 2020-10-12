
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example640318457/allocate.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	Wgdef c_closedTarget;
	bool state = false;
	run wgMonitor(c_closedTarget);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Anonymous0();
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Anonymous1();
	goto stop_process
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
stop_process:
}
proctype Anonymous1() {
	bool closed; 
	int i;
	do
	:: true;
	:: true -> 
		break
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