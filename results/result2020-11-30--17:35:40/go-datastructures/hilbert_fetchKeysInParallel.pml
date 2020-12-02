#define fetchKeysInParallel_numCPU  3
#define lb_for212_1  -1
#define ub_for212_2  -1

// /tmp/clone-example207091617/rtree/hilbert/tree.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int numCPU = fetchKeysInParallel_numCPU;
	Wgdef wg;
	bool state = false;
	int xns=0;
	int i;
	
	if
	:: 0 != -2 && xns-1 != -3 -> 
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
		:: true -> 
			break
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

