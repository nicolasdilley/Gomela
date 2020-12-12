
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example179359833/lib/testutils/httpmultibin/httpmultibin.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef grpcSrv_serveWG;
	Wgdef httpSrv_wg;
	int i;
	Wgdef httpsSrv_wg;
	Wgdef http2Srv_wg;
	bool state = false;
	run wgMonitor(httpSrv_wg);
	run wgMonitor(httpsSrv_wg);
	run wgMonitor(grpcSrv_serveWG);
	run wgMonitor(http2Srv_wg);
	goto stop_process
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
