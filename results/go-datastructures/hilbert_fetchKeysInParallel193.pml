#define fetchKeysInParallel_numCPU  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example574640073/rtree/hilbert/tree.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int numCPU = fetchKeysInParallel_numCPU;
	Wgdef wg;
	int i;
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
