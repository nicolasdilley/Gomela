
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example938799818/pkg/sdkserver/sdkserver.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef s_gsWaitForSync;
	bool state = false;
	int i;
	run wgMonitor(s_gsWaitForSync);
	s_gsWaitForSync.Add!1;
	goto stop_process
stop_process:skip
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
end: if
		:: wg.Add?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
	fi
od
}

