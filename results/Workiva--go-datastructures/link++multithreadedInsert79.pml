#define multithreadedInsert_chunks  3
#define not_found_96  -2

// https://github.com/Workiva/go-datastructures/blob/0819bcaf26091e7c33585441f8961854c2400faa/btree/_link/tree.go#L79
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	int chunks = multithreadedInsert_chunks;
	run wgMonitor(wg);
	wg.Add!chunks;
		for(i : 0.. chunks-1) {
		for10: skip;
		run go_Anonymous0(wg,not_found_96);
		for10_end: skip
	};
	for10_exit: skip;
	wg.Wait?0;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Wgdef wg;int chunk) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	wg.Add!-1
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

