#define GenerateNodeMap_vSphereInstances 1
#define GenerateNodeMap_dcName 0
#define GenerateNodeMap_datacenters 0
#define GenerateNodeMap_nodeList_Items 1
#define GenerateNodeMap_queueChannel 3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example808497976/test/e2e/storage/vsphere/nodemapper.go
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
		for(i : 0.. vSphereInstances-1) {
for10:		
		if
		:: true -> 
						for(i : 0.. dcName-1) {
for11:
			}
		:: true -> 
						for(i : 0.. dcName-1) {
for11:
			}
		fi;
				for(i : 0.. datacenters-1) {
for12:
		}
	};
		for(i : 0.. nodeList_Items-1) {
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
		for(i : 0.. queueChannel-1) {
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
	od
}

