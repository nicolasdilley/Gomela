
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example072515493/test/helpers/kubectl.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	int apps = 5;
	bool state = false;
	run wgMonitor(wg);
	wg.Add!apps;
		for(i : 1.. apps) {
for10:		run Anonymous0()
	};
	wg.Wait?0
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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
