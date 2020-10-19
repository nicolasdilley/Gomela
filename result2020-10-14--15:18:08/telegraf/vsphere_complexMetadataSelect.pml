#define complexMetadataSelect_objects  60
#define complexMetadataSelect_maxMetadataSamples  60
#define complexMetadataSelect_sampledObjects  60
#define complexMetadataSelect_metrics  60
#define complexMetadataSelect_mMap  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example985353586/plugins/inputs/vsphere/endpoint.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int sampledObjects = complexMetadataSelect_sampledObjects;
	int objects = complexMetadataSelect_objects;
	int mMap = complexMetadataSelect_mMap;
	Wgdef te_wg;
	int maxMetadataSamples = complexMetadataSelect_maxMetadataSamples;
	int metrics = complexMetadataSelect_metrics;
	int i;
		for(i : 1.. objects) {
for10:
	};
	
	if
	:: true -> 
		
		if
		:: 0 != -1 && maxMetadataSamples-1 != -1 -> 
						for(i : 0.. maxMetadataSamples-1) {
for20:
			}
		:: else -> 
			do
			:: true -> 
for20:
			:: true -> 
				break
			od
		fi;
for20_exit:
	:: true;
	fi;
	run wgMonitor(te_wg);
		for(i : 1.. sampledObjects) {
for30:
	}
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
