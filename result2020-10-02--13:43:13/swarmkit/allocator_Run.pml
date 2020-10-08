
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example004441286/manager/allocator/allocator.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	int actors = 5;
	bool state = false;
	run wgMonitor(wg);
		for(i : 1.. 1) {
for10:
	};
		for(i : 1.. actors) {
for20:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	};
	goto stop_process;
	wg.Wait?0
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
