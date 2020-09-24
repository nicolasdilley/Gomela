
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example675752547/manager.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef manager_disposeWait;
	int i;
	int manager_sessionMaps = 5;
	bool state = false;
	run wgMonitor(manager_disposeWait);
	
	if
	:: 0 != -1 && manager_sessionMaps-1 != -1 -> 
				for(i : 0.. manager_sessionMaps-1) {
for10:
		}
	:: else -> 
		do
		:: true -> 
for10:
		:: true -> 
			break
		od
	fi;
for10_exit:	goto stop_process
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
