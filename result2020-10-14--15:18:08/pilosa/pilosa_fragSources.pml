#define fragSources_to_nodes  60
#define fragSources_srcFrags  60
#define fragSources_frags  60
#define fragSources_tFrags  60
#define fragSources_diffs  60
#define fragSources_diff  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example953798272/cluster.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int diff = fragSources_diff;
	int srcFrags = fragSources_srcFrags;
	Wgdef srcCluster_wg;
	int tFrags = fragSources_tFrags;
	bool state = false;
	int to_nodes = fragSources_to_nodes;
	int frags = fragSources_frags;
	int diffs = fragSources_diffs;
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
	od;
stop_process:
}
