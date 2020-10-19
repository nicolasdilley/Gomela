#define healBucket_storageDisks  60
#define healBucket_beforeState  60
#define healBucket_afterState  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example604607877/cmd/erasure-healing.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int beforeState = healBucket_beforeState;
	Wgdef g_wg;
	int i;
	int storageDisks = healBucket_storageDisks;
	int afterState = healBucket_afterState;
	bool state = false;
	run wgMonitor(g_wg);
		for(i : 1.. storageDisks) {
for10:
	};
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. beforeState) {
for20:
	};
		for(i : 1.. storageDisks) {
for30:
	};
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. afterState) {
for40:
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
