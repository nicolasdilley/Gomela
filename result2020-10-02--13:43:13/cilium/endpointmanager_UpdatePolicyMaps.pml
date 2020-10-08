
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example072515493/pkg/endpointmanager/manager.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	Wgdef wg;
	Wgdef epWG;
	int eps = 5;
	bool state = false;
	run wgMonitor(epWG);
	run wgMonitor(wg);
	epWG.Add!eps;
	wg.Add!1;
	run Anonymous0(epWG,wg);
		for(i : 1.. eps) {
for10:		run Anonymous1(epWG,wg)
	};
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef epWG;Wgdef wg) {
	bool closed; 
	int i;
	epWG.Wait?0;
	wg.Add!-1;
stop_process:
}
proctype Anonymous1(Wgdef epWG;Wgdef wg) {
	bool closed; 
	int i;
	epWG.Add!-1;
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
