
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example942100504/test/e2e/storage/vsphere/nodemapper.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int dcName = 5;
	int i;
	int nodeList_Items = 5;
	Wgdef wg;
	int datacenters = 5;
	int queueChannel = 5;
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
