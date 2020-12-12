
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example052815095/client/allocrunner/taskrunner/logmon_hook.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef h_logmonPluginClient_clientWaitGroup;
	Wgdef c_clientWaitGroup;
	int i;
	Wgdef c_stderrWaitGroup;
	Wgdef h_logmonPluginClient_stderrWaitGroup;
	bool state = false;
	run wgMonitor(c_clientWaitGroup);
	run wgMonitor(c_stderrWaitGroup);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(h_logmonPluginClient_clientWaitGroup);
	run wgMonitor(h_logmonPluginClient_stderrWaitGroup);
	goto stop_process
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
