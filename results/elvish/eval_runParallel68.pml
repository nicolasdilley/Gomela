#define runParallel_functions  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example957006753/pkg/eval/builtin_fn_flow.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef waitg;
	int i;
	int functions = runParallel_functions;
	bool state = false;
	run wgMonitor(waitg);
	waitg.Add!functions;
	waitg.Wait?0;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef waitg) {
	bool closed; 
	int i;
	bool state;
	waitg.Add!-1;
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
