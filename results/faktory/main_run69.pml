#define run_threads  ??
#define run_int647211  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example454410783/test/load/main.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int threads = run_threads;
	Wgdef waiter;
	int int647211 = run_int647211;
	bool state = false;
	run wgMonitor(waiter);
		for(i : int647211.. threads-1) {
for10:		waiter.Add!1;
		run Anonymous0(waiter)
	};
for10_exit:	waiter.Wait?0
stop_process:}

proctype Anonymous0(Wgdef waiter) {
	bool closed; 
	int i;
	bool state;
stop_process:	waiter.Add!-1
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
