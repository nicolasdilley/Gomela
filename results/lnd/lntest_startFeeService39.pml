
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example982303966/lntest/fee_service.go
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
	bool state;
stop_process:	f_wg.Add!-1
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
