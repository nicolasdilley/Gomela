
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example872922038/futures/futures.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef f_wg;
	int i;
	Wgdef wg;
	bool state = false;
	run wgMonitor(f_wg);
	f_wg.Add!1;
	run wgMonitor(wg);
	wg.Add!1;
	run go_futureslistenForResult(wg);
	wg.Wait?0;
	goto stop_process
stop_process:}

proctype go_futureslistenForResult(Wgdef wg) {
	bool closed; 
	int i;
	wg.Add!-1;
	do
	:: true;
	od;
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
