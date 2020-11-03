#define markUpdatedPodsReady_pods 3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example808497976/test/integration/deployment/util.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	Wgdef wg;
	bool state = false;
	run wgMonitor(wg);
	wg.Add!1;
	run go_dmarkUpdatedPodsReady(wg);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	wg.Wait?0
stop_process:}

proctype go_dmarkUpdatedPodsReady(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
stop_process:	wg.Add!-1
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

