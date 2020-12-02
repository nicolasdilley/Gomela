#define IterativeRender_iterations  3

// /tmp/clone-example836832586/pt/renderer.go
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
		run go_rwriteImage(wg)
	};
for10_exit:	wg.Wait?0;
	goto stop_process
stop_process:}

proctype go_rwriteImage(Wgdef wg) {
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
