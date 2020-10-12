
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example165574471/lib/testutils/httpmultibin/httpmultibin.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	Wgdef httpsSrv_wg;
	Wgdef httpSrv_wg;
	Wgdef http2Srv_wg;
	bool state = false;
	run wgMonitor(httpSrv_wg);
	run wgMonitor(httpsSrv_wg);
	run wgMonitor(http2Srv_wg);
	goto stop_process
stop_process:}

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