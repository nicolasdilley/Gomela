
// /tmp/clone-example293849066/cluster.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int notYetAdded = -2;
	Wgdef wg;
	int cluster_servers_Slice56926 = -2;
	bool state = false;
	run wgMonitor(wg);
	wg.Wait?0;
	
	if
	:: true -> 
				for(i : 0.. notYetAdded-1) {
for20:
		}
	:: true -> 
				for(i : 0.. notYetAdded-1) {
for30:
		}
	:: true -> 
				for(i : 0.. notYetAdded-1) {
for30:
		}
	fi;
	
	if
	:: true -> 
				for(i : 0.. cluster_servers_Slice56926-1) {
for40:
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
