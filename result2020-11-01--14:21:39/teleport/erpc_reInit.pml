
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example360859129/context.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef c_sess_graceCtxWaitGroup;
	int i;
	Wgdef c_sess_graceCallCmdWaitGroup;
	bool state = false;
	run wgMonitor(c_sess_graceCtxWaitGroup);
	run wgMonitor(c_sess_graceCallCmdWaitGroup)
stop_process:}

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
