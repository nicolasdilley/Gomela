#define NewAlertServer_headers  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example832332134/services/httppost/httpposttest/server.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	Wgdef s_ts_wg;
	Wgdef ts_wg;
	int headers = NewAlertServer_headers;
	bool state = false;
	run wgMonitor(ts_wg);
	run wgMonitor(s_ts_wg);
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
