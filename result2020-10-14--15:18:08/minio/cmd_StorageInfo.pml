#define StorageInfo_z_zones  60
#define StorageInfo_storageInfos  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example604607877/cmd/erasure-zones.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int storageInfos = StorageInfo_storageInfos;
	Wgdef g_wg;
	bool state = false;
	int z_zones = StorageInfo_z_zones;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(g_wg);
		for(i : 1.. z_zones) {
for10:
	};
		for(i : 1.. storageInfos) {
for20:
	};
		for(i : 1.. z_zones) {
for30:
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
