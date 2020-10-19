#define GenerateNodeMap_vSphereInstances  60
#define GenerateNodeMap_dcName  60
#define GenerateNodeMap_datacenters  60
#define GenerateNodeMap_nodeList_Items  60
#define GenerateNodeMap_queueChannel  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example603064843/test/e2e/storage/vsphere/nodemapper.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int nodeList_Items = GenerateNodeMap_nodeList_Items;
	int dcName = GenerateNodeMap_dcName;
	int i;
	int vSphereInstances = GenerateNodeMap_vSphereInstances;
	int datacenters = GenerateNodeMap_datacenters;
	int queueChannel = GenerateNodeMap_queueChannel;
	bool state = false;
	run wgMonitor(wg);
		for(i : 1.. vSphereInstances) {
for10:		
		if
		:: true -> 
						for(i : 1.. dcName) {
for11:
			}
		:: true -> 
						for(i : 1.. dcName) {
for11:
			}
		fi;
				for(i : 1.. datacenters) {
for12:
		}
	};
		for(i : 1.. nodeList_Items) {
for20:		run Anonymous0(wg);
		wg.Add!1
	};
	wg.Wait?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
		for(i : 1.. queueChannel) {
for21:		
		if
		:: true -> 
			break
		:: true;
		fi
	};
	wg.Add!-1;
stop_process:
}
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
