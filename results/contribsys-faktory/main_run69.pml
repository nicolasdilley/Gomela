#define run_threads  3
#define run_int647211  1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example704239085/test/load/main.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef waiter;
	int num_msgs = 0;
	bool state = false;
	int i;
	int int647211 = run_int647211;
	int threads = run_threads;
	run wgMonitor(waiter);
		for(i : int647211.. threads-1) {
		for10: skip;
		waiter.Add!1;
		run go_Anonymous0(waiter);
		for10_end: skip
	};
	for10_exit: skip;
	waiter.Wait?0
stop_process:skip
}

proctype go_Anonymous0(Wgdef waiter) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	waiter.Add!-1
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

