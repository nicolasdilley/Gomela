#define Run_args_connlist  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example586753930/extern/deprecated/redis-test/bench/benchmark.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	int args_connlist = Run_args_connlist;
	

	if
	:: true -> 
		run wgMonitor(wg);
				for(i : 0.. args_connlist-1) {
			for10: skip;
			wg.Add!1;
			run go_Anonymous0(wg,wg);
			for10_end: skip
		};
		for10_exit: skip;
		wg.Wait?0
	:: true;
	fi;
	for20_exit: skip;
	

	if
	:: true -> 
				for(i : 0.. args_connlist-1) {
			for40: skip;
			wg.Add!1;
			run go_Anonymous1(wg,wg);
			for40_end: skip
		};
		for40_exit: skip;
		wg.Wait?0
	:: true;
	fi
stop_process:skip
}

proctype go_Anonymous0(Wgdef wg;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.Add!-1;
	stop_process: skip
}
proctype go_Anonymous1(Wgdef wg;Wgdef wg) {
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

