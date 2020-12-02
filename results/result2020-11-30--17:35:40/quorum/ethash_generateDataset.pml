#define generateDataset_threads  3

// /tmp/clone-example903492413/consensus/ethash/algorithm.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef pend;
	int i;
	int threads = generateDataset_threads;
	bool state = false;
	run wgMonitor(pend);
	pend.Add!threads;
for10_exit:	pend.Wait?0
stop_process:}

proctype Anonymous0(Wgdef pend) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: first != -2 && limit-1 != -3 -> 
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
for11_exit:stop_process:	pend.Add!-1
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
