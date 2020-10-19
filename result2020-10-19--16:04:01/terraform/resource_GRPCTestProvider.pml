
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example116360592/helper/resource/grpc_test_provider.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef grpcServer_serveWG;
	int i;
	Wgdef grpcClient_TestServer_serveWG;
	bool state = false;
	run wgMonitor(grpcServer_serveWG);
	run wgMonitor(grpcClient_TestServer_serveWG);
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
	od;
stop_process:
}
