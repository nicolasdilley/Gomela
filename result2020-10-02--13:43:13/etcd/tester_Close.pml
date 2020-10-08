
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example152234228/functional/tester/stresser_composite.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int cs_stressers = 5;
	Wgdef wg;
	int errs = 5;
	bool state = false;
	run wgMonitor(wg);
	wg.Add!cs_stressers;
		for(i : 1.. cs_stressers) {
for10:		run Anonymous0(wg)
	};
	wg.Wait?0;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
		for(i : 1.. errs) {
for11:
	};
	wg.Add!-1;
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
