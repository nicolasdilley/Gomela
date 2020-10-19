#define getZonesAvailableSpace_z_zones  60
#define getZonesAvailableSpace_storageInfos  60
#define getZonesAvailableSpace_zinfo_Disks  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example604607877/cmd/erasure-zones.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int storageInfos = getZonesAvailableSpace_storageInfos;
	Wgdef g_wg;
	int i;
	int z_zones = getZonesAvailableSpace_z_zones;
	int zinfo_Disks = getZonesAvailableSpace_zinfo_Disks;
	bool state = false;
	run wgMonitor(g_wg);
		for(i : 1.. z_zones) {
for10:
	};
		for(i : 1.. storageInfos) {
for20:				for(i : 1.. zinfo_Disks) {
for21:
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
