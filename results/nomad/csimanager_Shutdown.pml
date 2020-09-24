#define pluginMap  5
#define c_instances  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example542209901/client/pluginmanager/csimanager/manager.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int c_instances = 5;
	Wgdef wg;
	int pluginMap = 5;
	bool state = false;
	run wgMonitor(wg);
		for(i : 1.. c_instances) {
for10:				for(i : 1.. pluginMap) {
for11:			wg.Add!1;
			run Anonymous0(wg)
		}
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
