
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example354285826/pkg/kubelet/pluginmanager/pluginwatcher/example_plugin.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef e_grpcServer_serveWG;
	bool state = false;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(e_grpcServer_serveWG);
	run Anonymous0();
	goto stop_process
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	bool state;
stop_process:
}
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
