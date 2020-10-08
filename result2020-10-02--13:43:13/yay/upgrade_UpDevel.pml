
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example175635551/pkg/upgrade/sources.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int localCache_OriginsByPackage = 5;
	Wgdef wg;
	int toUpdate = 5;
	bool state = false;
	run wgMonitor(wg);
		for(i : 1.. localCache_OriginsByPackage) {
for10:		wg.Add!1
	};
	wg.Wait?0;
		for(i : 1.. toUpdate) {
for20:
	};
	goto stop_process
stop_process:}

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
