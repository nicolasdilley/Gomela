
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example244624373/consensus/ethash/algorithm.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int limit = 5;
	Wgdef pend;
	int i;
	int threads = 5;
	int first = 5;
	bool state = false;
	run wgMonitor(pend);
	pend.Add!threads;
		for(i : 0.. threads-1) {
for10:		run Anonymous0(pend)
	};
for10_exit:	pend.Wait?0
stop_process:}

proctype Anonymous0(Wgdef pend) {
	bool closed; 
	int i;
	
	if
	:: first != -1 && limit-1 != -1 -> 
				for(i : first.. limit-1) {
for11:
		}
	:: else -> 
		do
		:: true -> 
for11:
		:: true -> 
			break
		od
	fi;
for11_exit:	pend.Add!-1;
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
