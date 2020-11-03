#define Init_prog_AllFunctions 3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example955999608/_linters/src/honnef.co/go/tools/staticcheck/lint.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	int prog_AllFunctions = Init_prog_AllFunctions;
	bool state = false;
	run wgMonitor(wg);
	wg.Add!2;
	run Anonymous0();
	run Anonymous1();
	wg.Wait?0
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	bool state;
		for(i : 0.. prog_AllFunctions-1) {
for10:
	};
stop_process:
}
proctype Anonymous1() {
	bool closed; 
	int i;
	bool state;
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

