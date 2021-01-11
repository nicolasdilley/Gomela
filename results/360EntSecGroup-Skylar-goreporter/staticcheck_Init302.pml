#define Init_prog_Prog_AllPackages  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example478251678/linters/staticcheck/lint.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	bool state = false;
	int i;
	int prog_Prog_AllPackages = Init_prog_Prog_AllPackages;
	run wgMonitor(wg);
		for(i : 0.. prog_Prog_AllPackages-1) {
		for20: skip;
		wg.Add!1;
		run go_Anonymous0(wg);
		for20_end: skip
	};
	for20_exit: skip;
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

