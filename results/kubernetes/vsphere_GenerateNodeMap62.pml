#define GenerateNodeMap_nodeList_Items  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example354285826/test/e2e/storage/vsphere/nodemapper.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	int nodeList_Items = GenerateNodeMap_nodeList_Items;
	bool state = false;
	run wgMonitor(wg);
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
	do
	:: true -> 
for21:		
		if
		:: true -> 
			break
		:: true;
		fi
	:: true -> 
		break
	od;
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
