#define getServerSetsAvailableSpace_z_serverSets 3
#define getServerSetsAvailableSpace_storageInfos 0
#define getServerSetsAvailableSpace_zinfo_Disks 3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example320658119/cmd/erasure-server-sets.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int storageInfos = getServerSetsAvailableSpace_storageInfos;
	Wgdef g_wg;
	int i;
	int z_serverSets = getServerSetsAvailableSpace_z_serverSets;
	int zinfo_Disks = getServerSetsAvailableSpace_zinfo_Disks;
	bool state = false;
	run wgMonitor(g_wg);
		for(i : 0.. z_serverSets-1) {
for10:
	};
		for(i : 0.. storageInfos-1) {
for20:				for(i : 0.. zinfo_Disks-1) {
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
	od
}

