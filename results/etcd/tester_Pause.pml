
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example391587469/functional/tester/stresser_composite.go
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
	do
	:: true -> 
for10:		run Anonymous0(wg)
	:: true -> 
		break
	od;
	wg.Wait?0;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	do
	:: true -> 
for11:
	:: true -> 
		break
	od;
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
