#define getDisksInfo_endpoints 3
#define getDisksInfo_disks 0
#define getDisksInfo_errs 1
#define getDisksInfo_disksInfo 1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example320658119/cmd/erasure.go
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
		for(i : 0.. endpoints-1) {
for10:
	};
	run wgMonitor(g_wg);
		for(i : 0.. disks-1) {
for20:
	};
		for(i : 0.. errs-1) {
for30:
	};
		for(i : 0.. disksInfo-1) {
for40:
	};
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 0.. disksInfo-1) {
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
	od
}

