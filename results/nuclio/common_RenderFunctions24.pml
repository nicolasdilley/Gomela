#define RenderFunctions_functions  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example491159710/pkg/nuctl/command/common/renderers.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef waitGroup;
	int i;
	int functions = RenderFunctions_functions;
	bool state = false;
	run wgMonitor(waitGroup);
	waitGroup.Add!functions;
	waitGroup.Wait?0;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef waitGroup) {
	bool closed; 
	int i;
	bool state;
	waitGroup.Add!-1;
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
