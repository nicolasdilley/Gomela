#define Serve_services 1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example808497976/pkg/kubelet/pluginmanager/pluginwatcher/example_plugin.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int services = Serve_services;
	Wgdef e_grpcServer_serveWG;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(e_grpcServer_serveWG);
		for(i : 0.. services-1) {
for10:		

		if
		:: true;
		:: true;
		:: true -> 
			goto stop_process
		fi
	};
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

