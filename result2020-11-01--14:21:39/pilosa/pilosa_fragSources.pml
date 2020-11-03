#define fragSources_to_nodes  ??
#define fragSources_srcFrags  ??
#define fragSources_frags  ??
#define fragSources_tFrags  ??
#define fragSources_diffs  ??
#define fragSources_diff  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example981516145/cluster.go
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
		for(i : 0.. to_nodes-1) {
for10:
	};
	run wgMonitor(srcCluster_wg);
		for(i : 0.. srcFrags-1) {
for20:				for(i : 0.. frags-1) {
for21:
		}
	};
		for(i : 0.. tFrags-1) {
for30:
	};
		for(i : 0.. diffs-1) {
for40:				for(i : 0.. diff-1) {
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
	od
}
