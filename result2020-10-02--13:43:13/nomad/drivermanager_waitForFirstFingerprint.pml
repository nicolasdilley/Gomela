
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example190109984/client/pluginmanager/drivermanager/manager.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int m_instances = 5;
	Wgdef wg;
	int i;
	do
	:: true;
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	od;
	run wgMonitor(wg);
		for(i : 1.. m_instances) {
for10:		wg.Add!1;
		run Anonymous0(wg)
	};
	wg.Wait?0
stop_process:}

proctype Anonymous0(Wgdef wg) {
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