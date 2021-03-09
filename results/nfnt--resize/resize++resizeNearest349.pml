#define resizeNearest_cpus  3

// https://github.com/nfnt/resize/blob/83c6a9932646f83e3267f353373d47347b6036b2/resize.go#L349
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	int cpus = resizeNearest_cpus;
	run wgMonitor(wg);
	

	if
	:: true -> 
		wg.Add!cpus;
				for(i : 0.. cpus-1) {
			for10: skip;
			run go_Anonymous0(wg);
			for10_end: skip
		};
		for10_exit: skip;
		wg.Wait?0;
		wg.Add!cpus;
				for(i : 0.. cpus-1) {
			for20: skip;
			run go_Anonymous1(wg);
			for20_end: skip
		};
		for20_exit: skip;
		wg.Wait?0;
		goto stop_process
	:: true -> 
		wg.Add!cpus;
				for(i : 0.. cpus-1) {
			for30: skip;
			run go_Anonymous2(wg);
			for30_end: skip
		};
		for30_exit: skip;
		wg.Wait?0;
		wg.Add!cpus;
				for(i : 0.. cpus-1) {
			for40: skip;
			run go_Anonymous3(wg);
			for40_end: skip
		};
		for40_exit: skip;
		wg.Wait?0;
		goto stop_process
	:: true -> 
		wg.Add!cpus;
				for(i : 0.. cpus-1) {
			for50: skip;
			run go_Anonymous4(wg);
			for50_end: skip
		};
		for50_exit: skip;
		wg.Wait?0;
		wg.Add!cpus;
				for(i : 0.. cpus-1) {
			for60: skip;
			run go_Anonymous5(wg);
			for60_end: skip
		};
		for60_exit: skip;
		wg.Wait?0;
		goto stop_process
	:: true -> 
		wg.Add!cpus;
				for(i : 0.. cpus-1) {
			for70: skip;
			run go_Anonymous6(wg);
			for70_end: skip
		};
		for70_exit: skip;
		wg.Wait?0;
		wg.Add!cpus;
				for(i : 0.. cpus-1) {
			for80: skip;
			run go_Anonymous7(wg);
			for80_end: skip
		};
		for80_exit: skip;
		wg.Wait?0;
		goto stop_process
	:: true -> 
		wg.Add!cpus;
				for(i : 0.. cpus-1) {
			for90: skip;
			run go_Anonymous8(wg);
			for90_end: skip
		};
		for90_exit: skip;
		wg.Wait?0;
		wg.Add!cpus;
				for(i : 0.. cpus-1) {
			for100: skip;
			run go_Anonymous9(wg);
			for100_end: skip
		};
		for100_exit: skip;
		wg.Wait?0;
		goto stop_process
	:: true -> 
		wg.Add!cpus;
				for(i : 0.. cpus-1) {
			for110: skip;
			run go_Anonymous10(wg);
			for110_end: skip
		};
		for110_exit: skip;
		wg.Wait?0;
		wg.Add!cpus;
				for(i : 0.. cpus-1) {
			for120: skip;
			run go_Anonymous11(wg);
			for120_end: skip
		};
		for120_exit: skip;
		wg.Wait?0;
		goto stop_process
	:: true -> 
		wg.Add!cpus;
				for(i : 0.. cpus-1) {
			for130: skip;
			run go_Anonymous12(wg);
			for130_end: skip
		};
		for130_exit: skip;
		wg.Wait?0;
		wg.Add!cpus;
				for(i : 0.. cpus-1) {
			for140: skip;
			run go_Anonymous13(wg);
			for140_end: skip
		};
		for140_exit: skip;
		wg.Wait?0;
		goto stop_process
	:: true -> 
		wg.Add!cpus;
				for(i : 0.. cpus-1) {
			for150: skip;
			run go_Anonymous14(wg);
			for150_end: skip
		};
		for150_exit: skip;
		wg.Wait?0;
		wg.Add!cpus;
				for(i : 0.. cpus-1) {
			for160: skip;
			run go_Anonymous15(wg);
			for160_end: skip
		};
		for160_exit: skip;
		wg.Wait?0;
		goto stop_process
	fi
stop_process:skip
}

proctype go_Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous1(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous2(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous3(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous4(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous5(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous6(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous7(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous8(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous9(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous10(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous11(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous12(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous13(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous14(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous15(Wgdef wg) {
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

