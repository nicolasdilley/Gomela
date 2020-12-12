
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example714267106/commands/command_migrate_export.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int q_Errors14623 = -2;
	bool state = false;
	int i;
	
	if
	:: true -> 
		Wgdef q_collectorWait;
		run wgMonitor(q_collectorWait);
		Wgdef q_errorwait;
		run wgMonitor(q_errorwait);
				for(i : 0.. q_Errors14623-1) {
for10:
		}
	:: true;
	fi
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
