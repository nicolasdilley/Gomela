
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example668279948/cluster.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int diff = 5;
	int srcFrags = 5;
	Wgdef srcCluster_wg;
	int tFrags = 5;
	bool state = false;
	int to_nodes = 5;
	int frags = 5;
	int diffs = 5;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. to_nodes) {
for10:
	};
	run wgMonitor(srcCluster_wg);
	
	if
	:: true -> 
		Wgdef srcCluster_wg;
		run wgMonitor(srcCluster_wg)
	:: true;
	fi;
		for(i : 1.. srcFrags) {
for20:				for(i : 1.. frags) {
for21:
		}
	};
		for(i : 1.. tFrags) {
for30:
	};
		for(i : 1.. diffs) {
for40:				for(i : 1.. diff) {
for41:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		}
	};
	goto stop_process
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
