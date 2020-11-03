#define generateDataset_threads 1
#define generateDataset_limit 0
#define generateDataset_first 0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example127052982/consensus/ethash/algorithm.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int limit = generateDataset_limit;
	Wgdef pend;
	int i;
	int threads = generateDataset_threads;
	int first = generateDataset_first;
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
	bool state;
	
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

