
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example748741455/each.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef done;
	int i;
	int keys = 5;
	bool state = false;
	run wgMonitor(done);
	done.Add!keys;
	do
	:: true -> 
for10:		run Anonymous0(done)
	:: true -> 
		break
	od;
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
