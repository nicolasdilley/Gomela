
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example460794320/tools/github/reviver/reviver.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int r_paths = 5;
	Wgdef wg;
	int r_todos = 5;
	bool state = false;
	run wgMonitor(wg);
		for(i : 1.. r_paths) {
for10:		wg.Add!1;
		run Anonymous0()
	};
	wg.Wait?0;
		for(i : 1.. r_todos) {
for20:
	};
	goto stop_process
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
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
