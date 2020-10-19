#define getDisksInfo_endpoints  60
#define getDisksInfo_disks  60
#define getDisksInfo_errs  60
#define getDisksInfo_disksInfo  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example604607877/cmd/erasure.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef g_wg;
	int disksInfo = getDisksInfo_disksInfo;
	int disks = getDisksInfo_disks;
	bool state = false;
	int endpoints = getDisksInfo_endpoints;
	int errs = getDisksInfo_errs;
	int i;
		for(i : 1.. endpoints) {
for10:
	};
	run wgMonitor(g_wg);
		for(i : 1.. disks) {
for20:
	};
		for(i : 1.. errs) {
for30:
	};
		for(i : 1.. disksInfo) {
for40:
	};
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. disksInfo) {
for50:
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
