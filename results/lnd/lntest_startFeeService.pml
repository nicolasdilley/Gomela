
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example671499408/lntest/fee_service.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	Wgdef f_wg;
	bool state = false;
	run wgMonitor(f_wg);
	f_wg.Add!1;
	run Anonymous0(f_wg);
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef f_wg) {
	bool closed; 
	int i;
	f_wg.Add!-1;
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
