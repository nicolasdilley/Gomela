#define Build_prog_packages  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example415655485/_linters/src/honnef.co/go/tools/ssa/builder.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	bool state = false;
	int i;
	int prog_packages = Build_prog_packages;
	run wgMonitor(wg);
		for(i : 0.. prog_packages-1) {
		for10: skip;
		

		if
		:: true -> 
			wg.Add!1;
			run go_Anonymous0(wg)
		:: true -> 
			wg.Add!1;
			run go_Anonymous0(wg)
		fi;
		for10_end: skip
	};
	for10_exit: skip;
	wg.Wait?0
stop_process:skip
}

proctype go_Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	wg.Add!-1;
	stop_process: skip
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

