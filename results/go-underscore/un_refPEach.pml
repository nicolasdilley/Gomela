#define slice  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example748741455/each.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	Wgdef done;
	bool state = false;
	run wgMonitor(done);
		for(i : 1.. slice) {
for10:		done.Add!1;
		run Anonymous0(done)
	};
	done.Wait?0
stop_process:}

proctype Anonymous0(Wgdef done) {
	bool closed; 
	int i;
	done.Add!-1;
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
