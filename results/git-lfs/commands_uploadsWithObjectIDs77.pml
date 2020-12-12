
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example714267106/commands/command_push.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef q_collectorWait;
	int i;
	Wgdef q_errorwait;
	bool state = false;
	run wgMonitor(q_collectorWait);
	run wgMonitor(q_errorwait)
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
