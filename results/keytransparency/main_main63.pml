
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example699315778/cmd/keytransparency-server/main.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef grpcServer_serveWG;
	int i;
	Wgdef g_wg;
	bool state = false;
	run wgMonitor(grpcServer_serveWG);
	run wgMonitor(g_wg)
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
