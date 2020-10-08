
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example072515493/pkg/policy/repository.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	int p_rules = 5;
	bool state = false;
	run wgMonitor(wg);
	wg.Add!p_rules;
		for(i : 1.. p_rules) {
for10:		run Anonymous0(wg)
	};
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wgg) {
	bool closed; 
	int i;
	wgg.Add!-1;
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
