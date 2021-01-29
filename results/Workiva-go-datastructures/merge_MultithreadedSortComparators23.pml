#define MultithreadedSortComparators_chunks  1
#define ub_for48_1  1
#define ub_for45_2  0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example114682176/sort/sort.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	int chunks = MultithreadedSortComparators_chunks;
	run wgMonitor(wg);
	wg.Add!chunks;
		for(i : 0.. chunks-1) {
		for10: skip;
		run go_Anonymous0(wg);
		for10_end: skip
	};
	for10_exit: skip;
	wg.Wait?0;
		for(i : 0.. ub_for45_2) {
		for20: skip;
		wg.Add!chunks / 2;
				for(i : 0.. ub_for48_1) {
			for21: skip;
			run go_Anonymous1(wg);
			for21_end: skip
		};
		for21_exit: skip;
		wg.Wait?0;
		

		if
		:: true -> 
			break
		:: true;
		fi;
		for20_end: skip
	};
	for20_exit: skip;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.Add!-1;
	stop_process: skip
}
proctype go_Anonymous1(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.Add!-1;
	stop_process: skip
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

