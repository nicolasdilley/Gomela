#define IterativeRender_iterations  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example193350674/pt/renderer.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	int iterations = IterativeRender_iterations;
	bool state = false;
	run wgMonitor(wg);
		for(i : 1.. iterations) {
for10:		wg.Add!1;
		run go_writeImage(wg)
	};
for10_exit:	wg.Wait?0;
	goto stop_process
stop_process:}

proctype go_writeImage(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
stop_process:	wg.Add!-1
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
