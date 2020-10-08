
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example942100504/staging/src/k8s.io/legacy-cloud-providers/azure/clients/armclient/azure_armclient.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int futures = 5;
	Wgdef wg;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. resources) {
for10:
	};
	run wgMonitor(wg);
		for(i : 1.. futures) {
for20:		wg.Add!1;
		run Anonymous0()
	};
	wg.Wait?0;
	goto stop_process
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
