#define Compute_parameters_UnitTestDirs  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example439685998/engine/strategy_unittest.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef pkg;
	int num_msgs = 0;
	bool state = false;
	int i;
	int parameters_UnitTestDirs = Compute_parameters_UnitTestDirs;
	run wgMonitor(pkg);
		for(i : 0.. parameters_UnitTestDirs-1) {
		for10: skip;
		pkg.Add!1;
		run go_Anonymous0(pkg);
		for10_end: skip
	};
	for10_exit: skip;
	pkg.Wait?0;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Wgdef pkg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	pkg.Add!-1;
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

