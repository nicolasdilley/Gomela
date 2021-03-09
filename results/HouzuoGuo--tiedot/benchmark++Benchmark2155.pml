#define Benchmark2_numThreads  3

// https://github.com/HouzuoGuo/tiedot/blob/6fb216206052eb2ae4306cf5e75acfa88f60d481/benchmark/benchmark.go#L155
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wp;
	int num_msgs = 0;
	bool state = false;
	int i;
	int numThreads = Benchmark2_numThreads;
	run wgMonitor(wp);
	wp.Add!5 * numThreads;
	wp.Add!1;
		for(i : 0.. numThreads-1) {
		for20: skip;
		run go_Anonymous0(wp,numThreads);
		for20_end: skip
	};
	for20_exit: skip;
		for(i : 0.. numThreads-1) {
		for30: skip;
		run go_Anonymous1(wp,numThreads);
		for30_end: skip
	};
	for30_exit: skip;
		for(i : 0.. numThreads-1) {
		for40: skip;
		run go_Anonymous2(wp,numThreads);
		for40_end: skip
	};
	for40_exit: skip;
		for(i : 0.. numThreads-1) {
		for50: skip;
		run go_Anonymous3(wp,numThreads);
		for50_end: skip
	};
	for50_exit: skip;
		for(i : 0.. numThreads-1) {
		for60: skip;
		run go_Anonymous4(wp,numThreads);
		for60_end: skip
	};
	for60_exit: skip;
	run go_Anonymous5(wp);
	wp.Wait?0
stop_process:skip
}

proctype go_Anonymous0(Wgdef wp;int numThreads) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	wp.Add!-1
}
proctype go_Anonymous1(Wgdef wp;int numThreads) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	wp.Add!-1
}
proctype go_Anonymous2(Wgdef wp;int numThreads) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	wp.Add!-1
}
proctype go_Anonymous3(Wgdef wp;int numThreads) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	wp.Add!-1
}
proctype go_Anonymous4(Wgdef wp;int numThreads) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	wp.Add!-1
}
proctype go_Anonymous5(Wgdef wp) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	wp.Add!-1
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
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

