#define Run_args_connlist  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example418070052/extern/deprecated/redis-test/bench/benchmark.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int args_connlist = Run_args_connlist;
	bool state = false;
	int i;
	
	if
	:: true -> 
		Wgdef wg;
		run wgMonitor(wg);
				for(i : 0.. args_connlist-1) {
for10:			wg.Add!1;
			run Anonymous0(wg,wg)
		};
		wg.Wait?0
	:: true;
	fi;
for30_exit:	
	if
	:: true -> 
				for(i : 0.. args_connlist-1) {
for40:			wg.Add!1;
			run Anonymous1(wg,wg)
		};
		wg.Wait?0
	:: true;
	fi
stop_process:}

proctype Anonymous0(Wgdef wg;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
for11_exit:	wg.Add!-1;
stop_process:
}
proctype Anonymous1(Wgdef wg;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
for41_exit:	wg.Add!-1;
stop_process:
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
