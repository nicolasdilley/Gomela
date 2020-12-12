#define fetchData_d_Datacenters  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example353702328/uchiwa/daemon/daemon.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	int d_Datacenters = fetchData_d_Datacenters;
	bool state = false;
	run wgMonitor(wg);
		for(i : 0.. d_Datacenters-1) {
for10:		wg.Add!1
	};
	wg.Wait?0
stop_process:}

proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
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
	od
}
