#define Server_stubs 1
#define Server_stub_Headers 0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example799795789/pkg/test/server.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int stubs = Server_stubs;
	Wgdef ts_wg;
	int stub_Headers = Server_stub_Headers;
	bool state = false;
	run wgMonitor(ts_wg);
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

