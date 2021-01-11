#define generateDataset_threads  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example434979571/consensus/ethash/algorithm.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef pend;
	bool state = false;
	int i;
	int threads = generateDataset_threads;
	run wgMonitor(pend);
	pend.Add!threads;
		for(i : 0.. threads-1) {
		for10: skip;
		run go_Anonymous0(pend);
		for10_end: skip
	};
	for10_exit: skip;
	pend.Wait?0
stop_process:skip
}

proctype go_Anonymous0(Wgdef pend) {
	bool closed; 
	int i;
	bool state;
	stop_process: skip;
	pend.Add!-1
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
end: if
		:: wg.Add?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
	fi
od
}

