
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example944348109/engine/strategy_unittest.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef pkg;
	int i;
	int parameters_UnitTestDirs = 5;
	bool state = false;
	run wgMonitor(pkg);
		for(i : 1.. parameters_UnitTestDirs) {
for10:		pkg.Add!1;
		run Anonymous0(pkg)
	};
	pkg.Wait?0;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef pkg) {
	bool closed; 
	int i;
	pkg.Add!-1;
stop_process:
}
proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
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
	od;
stop_process:
}
