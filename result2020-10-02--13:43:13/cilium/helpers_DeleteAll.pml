
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example072515493/test/helpers/manifest.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int m_deployments = 5;
	Wgdef wg;
	int namespaces = 5;
	bool state = false;
	run wgMonitor(wg);
	wg.Add!m_deployments;
		for(i : 1.. m_deployments) {
for10:		run Anonymous0(wg)
	};
		for(i : 1.. m_deployments) {
for20:
	};
	wg.Wait?0;
	wg.Add!namespaces;
		for(i : 1.. namespaces) {
for30:		run Anonymous1(wg)
	};
	wg.Wait?0
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	wg.Add!-1;
stop_process:
}
proctype Anonymous1(Wgdef wg) {
	bool closed; 
	int i;
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
