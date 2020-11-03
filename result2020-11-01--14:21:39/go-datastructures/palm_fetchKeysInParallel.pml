#define fetchKeysInParallel_xns 0
#define fetchKeysInParallel_numCPU 0
#define lb_for295_2  -1
#define ub_for295_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example401606570/btree/palm/tree.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int numCPU = fetchKeysInParallel_numCPU;
	Wgdef wg;
	bool state = false;
	int xns = fetchKeysInParallel_xns;
	int i;
	
	if
	:: 0 != -1 && xns-1 != -1 -> 
				for(i : 0.. xns-1) {
for10:
		}
	:: else -> 
		do
		:: true -> 
for10:
		:: true -> 
			break
		od
	fi;
for10_exit:	run wgMonitor(wg);
	wg.Add!numCPU;
		for(i : 0.. numCPU-1) {
for20:		run Anonymous0(wg)
	};
for20_exit:	wg.Wait?0
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
		fi;
		

		if
		:: true;
		:: true;
		:: true;
		fi
	od;
for21_exit:	wg.Add!-1;
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

